class DbmGeneratorController < ApplicationController
  layout false

  # TEMPLATE_PATH = Rails.root.join('app', 'views', 'workers', 'dbm_generator')
  TEMPLATE_PATH = Rails.root.join('app', 'views', 'workers', 'dbm_generator')
  FILE_PATH = '/home/shared/'.freeze

  # def new
  #   @dbm_generator = ::SelectBuilder::Settings.new('type' => 'pds_rf', 'project_id' => params[:pds_project_id])
  # end

  def prepare_hash
    hash = params[:data]
    dbm_generator = DbmGenerator.new(hash)
    # Resque.enqueue(SelectBuilderJob, dbm_generator)
    # dbm_generator = @dbm_generator
    render_pds_rf(dbm_generator)
    render json: { status: :ok }
  end

  def render_pds_rf(dbm_generator)
    systems = dbm_generator.systems
    data_tot = ''
    systems.each do |sys_id|
      sys_name = PdsSyslist.find(sys_id).System.tr('/', '_')
      pds_rfs = PdsRf.where(Project: dbm_generator.project_id).where(sys: sys_id).includes(:system).order('pds_syslist.System').all
      data = Tilt.new(TEMPLATE_PATH.join('pds_rf.sel.erb').to_s).render(ActionView::Base.new, dbm_generator.as_json.merge(data: pds_rfs))
      data_tot += data if dbm_generator.systems_all?
      File.open(FILE_PATH + 'pds_rf_' + sys_name + '.sel', 'w:UTF-8') { |f| f << data.encode('utf-8', invalid: :replace, undef: :replace, replace: '') }
    end
    if dbm_generator.systems_all?
      File.open(FILE_PATH + 'pds_rf.sel', 'w:UTF-8') { |f| f << data_tot.encode('utf-8', invalid: :replace, undef: :replace, replace: '') }
    end
  end

  def render_pds_mf(dbm_generator)
    systems = dbm_generator.systems
    data_tot = ''
    systems.each do |sys_id|
      sys_name = PdsSyslist.find(sys_id).System.tr('/', '_')
      pds_mfs = PdsMalfunction.where(Project: dbm_generator.project_id).where(sys: sys_id).includes(:system).order('pds_syslist.System').all
      data = Tilt.new(TEMPLATE_PATH.join('pds_mf.sel.erb').to_s).render(ActionView::Base.new, dbm_generator.as_json.merge(data: pds_mfs))
      data_tot += data if dbm_generator.systems_all?
      File.open(FILE_PATH + 'pds_mf_' + sys_name + '.sel', 'w:UTF-8') { |f| f << data.encode('utf-8', invalid: :replace, undef: :replace, replace: '') }
    end
    if dbm_generator.systems_all?
      File.open(FILE_PATH + 'pds_mf.sel', 'w:UTF-8') { |f| f << data_tot.encode('utf-8', invalid: :replace, undef: :replace, replace: '') }
    end
  end
end
