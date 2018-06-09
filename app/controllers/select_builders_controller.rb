class SelectBuildersController < ApplicationController
  layout false

  TEMPLATE_PATH = Rails.root.join('app', 'views', 'workers', 'select_builder')
  # FILE_PATH = Rails.root.join('public', 'select_builders', 'pds_rf.sel')
  FILE_PATH = '/home/shared/pds_rf.sel'.freeze

  def new
    @select_builder = ::SelectBuilder::Settings.new('type' => 'pds_rf', 'project_id' => params[:pds_project_id])
  end

  def create
    hash = params[:select_builder_settings]
    @select_builder = ::SelectBuilder::Settings.new(hash)
    # Resque.enqueue(SelectBuilderJob, @select_builder)
    select_builder = @select_builder
    render_pds_rf(select_builder)
  end

  def render_pds_rf(select_builder)
    pds_rfs = PdsRf.where(Project: select_builder.project_id).where(sys: select_builder.systems).includes(:system).order('pds_syslist.System')
    data = Tilt.new(TEMPLATE_PATH.join('pds_rf.sel.erb').to_s).render(ActionView::Base.new, select_builder.as_json.merge(data: pds_rfs))
    File.open(FILE_PATH, 'w:UTF-8') { |f| f << data.encode('utf-8', invalid: :replace, undef: :replace, replace: '') }
  end
end
