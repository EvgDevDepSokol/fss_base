class SelectBuilderJob
  @queue = :selects

  def self.perform(seconds)
    sleep(seconds)
  end

  TEMPLATE_PATH = Rails.root.join('app', 'views', 'workers', 'select_builder')
  FILE_PATH = Rails.root.join('public', 'select_builders', 'pds_rf.sel')

  def work
  end

  def data
  end

  def render_pds_rf(select_builder)
    pds_rfs = PdsRf.where(Project: select_builder.project_id).includes(:system)
    data = Tilt.new(TEMPLATE_PATH.join('pds_rf.sel.erb').to_s).render(ActionView::Base.new, select_builder.as_json.merge(data: pds_rfs))
    File.open(FILE_PATH, 'w:KOI8-R') { |f| f << data.encode('koi8-r', invalid: :replace, undef: :replace, replace: '') }
  end

  def render_pds_mf(select_builder)
    pds_malfunctions = PdsMalfunction.where(Project: select_builder.project_id).includes(:system)
    data = Tilt.new(TEMPLATE_PATH.join('pds_malfunction.sel.erb').to_s).render(ActionView::Base.new, select_builder.as_json.merge(data: pds_malfunction))
    File.open(FILE_PATH, 'w:KOI8-R') { |f| f << data.encode('koi8-r', invalid: :replace, undef: :replace, replace: '') }
  end

  def select_builder
  end
end
