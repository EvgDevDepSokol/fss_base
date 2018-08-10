class DbmGeneratorController < ApplicationController
  require 'net/scp'
  layout false

  TEMPLATE_PATH = Rails.root.join('app', 'views', 'workers', 'dbm_generator')
  FILE_PATH = '/home/shared/'.freeze

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
    is_rus = rus?(dbm_generator.project_id)
    enc = project_encoding(dbm_generator.project_id)
    ssh = project_ssh(dbm_generator.project_id)
    Net::SCP.start(ssh[:ip], 'load', password: ssh[:pass]) do |scp|
      systems.each do |sys_id|
        sys_name = PdsSyslist.find(sys_id).System.tr('/', '_')
        pds_rfs = PdsRf.where(Project: dbm_generator.project_id).where(sys: sys_id).includes(:system).all
        data_sys = Tilt.new(TEMPLATE_PATH.join('pds_rf.sel.erb').to_s)
                   .render(ActionView::Base.new, dbm_generator.as_json.merge(data: pds_rfs, is_rus: is_rus))
        data_tot += data_sys if dbm_generator.systems_all?
        next unless data_sys > ''
        file_name = 'pds_rf_' + sys_name + '.sel'
        create_file(file_name, enc, data_sys)
        scp.upload! @local_path, ssh[:remote_path] + file_name
      end
      if dbm_generator.systems_all?
        file_name = 'pds_rf.sel'
        create_file(file_name, enc, data_tot)
        scp.upload! @local_path, ssh[:remote_path] + file_name
      end
    end
  end

  def render_pds_mf(dbm_generator)
    systems = dbm_generator.systems
    data_tot = ''
    is_rus = rus?(dbm_generator.project_id)
    enc = project_encoding(dbm_generator.project_id)
    ssh = project_ssh(dbm_generator.project_id)
    Net::SCP.start(ssh[:ip], 'load', password: ssh[:pass]) do |scp|
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
          data = Tilt.new(TEMPLATE_PATH.join(path).to_s).render(
            ActionView::Base.new, dbm_generator.as_json.merge(pds_mf: pds_mf, pds_mf_dims: pds_mf_dims, is_rus: is_rus)
          )
          data_sys += data
        end
        data_tot += data_sys if dbm_generator.systems_all?
        next unless data_sys > ''
        file_name = 'pds_malf_' + sys_name + '.sel'
        create_file(file_name, enc, data_sys)
        scp.upload! @local_path, ssh[:remote_path] + file_name
      end
      if dbm_generator.systems_all?
        file_name = 'pds_malf.sel'
        create_file(file_name, enc, data_tot)
        scp.upload! @local_path, ssh[:remote_path] + file_name
      end
    end
  end

  def rus?(project_id)
    PdsProject.find(project_id).project_properties.language == 'Русский'
  end

  def project_encoding(project_id)
    enc = PdsProject.find(project_id).project_properties.Encoding
    return 'KOI8-R' if enc == 'koi8r'
    return 'Windows-1251' if enc == 'cp1251'
    'UTF-8'
  end

  def project_ssh(project_id)
    prop = PdsProject.find(project_id).project_properties
    { ip: prop.HostIP, pass: prop.LoadPass, remote_path: '/home/' + prop.SimDir + 'load/pds_sel_test/' }
  end

  def create_file(file_name, enc, data)
    @file_name = file_name
    @local_path = FILE_PATH + file_name
    File.open(@local_path, 'w:' + enc) do |f|
      f << data.encode(enc, invalid: :replace, undef: :replace, replace: '', universal_newline: true)
    end
  end
end
