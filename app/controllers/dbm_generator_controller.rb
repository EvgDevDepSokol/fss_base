class DbmGeneratorController < ApplicationController
  layout false

  TEMPLATE_PATH = Rails.root.join('app', 'views', 'workers', 'dbm_generator')
  FILE_PATH = '/home/shared/'.freeze

  def prepare_hash
    hash = params[:data]
    dbm_generator = DbmGenerator.new(hash)
    # Resque.enqueue(SelectBuilderJob, dbm_generator)
    # dbm_generator = @dbm_generator
    render_pds_mf(dbm_generator)
    render json: { status: :ok }
  end

  def render_pds_rf(dbm_generator)
    systems = dbm_generator.systems
    data_tot = ''
    is_rus = is_rus?(dbm_generator.project_id)
    systems.each do |sys_id|
      sys_name = PdsSyslist.find(sys_id).System.tr('/', '_')
      pds_rfs = PdsRf.where(Project: dbm_generator.project_id).where(sys: sys_id).includes(:system).all
      data = Tilt.new(TEMPLATE_PATH.join('pds_rf.sel.erb').to_s).render(ActionView::Base.new, dbm_generator.as_json.merge(data: pds_rfs, is_rus: is_rus))
      data_tot += data if dbm_generator.systems_all?
      if data > ''
        File.open(FILE_PATH + 'pds_rf_' + sys_name + '.sel', 'w:UTF-8') { |f| f << data.encode('utf-8', invalid: :replace, undef: :replace, replace: '') }
      end
    end
    if dbm_generator.systems_all?
      File.open(FILE_PATH + 'pds_rf.sel', 'w:UTF-8') { |f| f << data_tot.encode('utf-8', invalid: :replace, undef: :replace, replace: '') }
    end
  end

  def render_pds_mf(dbm_generator)
    systems = dbm_generator.systems
    data_tot = ''
    is_rus = is_rus?(dbm_generator.project_id)
    systems.each do |sys_id|
      sys_name = PdsSyslist.find(sys_id).System.tr('/', '_')
      pds_mfs = PdsMalfunction.where(Project: dbm_generator.project_id).where(sys: sys_id).includes(:system).order(:Numb).all
      data_sys = ''
      pds_mfs.each do |pds_mf|
        if pds_mf.Dimension == 1
          pds_mf_dims = ''
          path = if pds_mf.type_b?(pds_mf.type)
                   'pds_mf_l1.sel.erb'
                 else
                   'pds_mf_r1.sel.erb'
                 end
        else
          pds_mf_dims = PdsMalfunctionDim.where(Malfunction: pds_mf.id).order(:Character).to_a
          path = if pds_mf.type_b?(pds_mf.type)
                   'pds_mf_l2.sel.erb'
                 else
                   'pds_mf_r2.sel.erb'
                 end
        end
        data = Tilt.new(TEMPLATE_PATH.join(path).to_s).render(ActionView::Base.new, dbm_generator.as_json.merge(pds_mf: pds_mf, pds_mf_dims: pds_mf_dims, is_rus: is_rus))
        data_sys += data
      end
      data_tot += data_sys if dbm_generator.systems_all?
      if data_sys > ''
        File.open(FILE_PATH + 'pds_malf_' + sys_name + '.sel', 'w:UTF-8') { |f| f << data_sys.encode('utf-8', invalid: :replace, undef: :replace, replace: '') }
      end
    end
    if dbm_generator.systems_all?
      File.open(FILE_PATH + 'pds_malf.sel', 'w:UTF-8') { |f| f << data_tot.encode('utf-8', invalid: :replace, undef: :replace, replace: '') }
    end
  end

  def is_rus?(project_id)
    PdsProject.find(project_id).project_properties.language == 'Русский'
  end
end
