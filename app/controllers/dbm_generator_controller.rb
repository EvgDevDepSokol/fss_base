class DbmGeneratorController < ApplicationController
  require 'net/ssh'
  require 'net/scp'
  layout false

  TEMPLATE_PATH = Rails.root.join('app', 'views', 'workers', 'dbm_generator')
  FILE_PATH = '/home/shared/'.freeze

  def prepare_hash
    hash = params[:data]
    #dbm_generator = DbmGenerator.new(hash)
    current_user.message = ''
    current_user.save
    #Resque.enqueue(SelectBuilderJob, hash)
    case dbm_generator.type
    when '0'
      render_sel_rf(dbm_generator)
    when '1'
      render_sel_mf(dbm_generator)
    when '3'
      render_sel_ped(dbm_generator)
    end
    render json: { status: :ok }
  end

  def get_log
    log = current_user.message
    render json: { log: log }
  end

  def render_sel_rf(dbm_generator)
    write_log('Инициализация...')
    systems = dbm_generator.systems
    data_tot = ''
    is_rus = dbm_generator.rus?(dbm_generator.project_id)
    enc = dbm_generator.project_encoding(dbm_generator.project_id)
    ssh = dbm_generator.project_ssh(dbm_generator.project_id)
    ssh[:remote_path] += 'gen_rf/'
    write_log('Подключение к серверу: ' + ssh[:ip] + '.')
    Net::SSH.start(ssh[:ip], 'load', password: ssh[:pass]) do |session|
      session.exec!('mkdir ' + ssh[:remote_path])
      systems.each do |sys_id|
        sys_name = PdsSyslist.find(sys_id).System.tr('/', '_')
        write_log('Генерация селект-файла для ' + sys_name + '.')
        pds_rfs = PdsRf.where(Project: dbm_generator.project_id).where(sys: sys_id).includes(:system).all
        data_sys = Tilt.new(TEMPLATE_PATH.join('pds_rf.sel.erb').to_s)
                       .render(ActionView::Base.new, dbm_generator.as_json.merge(data: pds_rfs, is_rus: is_rus))
        if dbm_generator.systems_all?
          data_tot += data_sys
        elsif data_sys > ''
          file_name = 'pds_rf_' + sys_name + '.sel'
          create_file(file_name, enc, data_sys)
          session.scp.upload! @local_path, ssh[:remote_path] + file_name
          write_log('Файл ' + file_name + ' загружен на сервер.')
        end
      end
      if dbm_generator.systems_all?
        file_name = 'pds_rf_ALL.sel'
        create_file(file_name, enc, data_tot)
        session.scp.upload! @local_path, ssh[:remote_path] + file_name
        write_log('Файл ' + file_name + ' загружен на сервер.')
      end
    end
    write_log('Генерация завершена.')
    write_log('Файлы размещены в ' + ssh[:remote_path])
  end

  def render_sel_mf(dbm_generator)
    systems = dbm_generator.systems
    data_tot = ''
    is_rus = dbm_generator.rus?(dbm_generator.project_id)
    enc = dbm_generator.project_encoding(dbm_generator.project_id)
    ssh = dbm_generator.project_ssh(dbm_generator.project_id)
    ssh[:remote_path] += 'gen_mf/'
    write_log('Подключение к серверу: ' + ssh[:ip] + '.')
    Net::SSH.start(ssh[:ip], 'load', password: ssh[:pass]) do |session|
      session.exec!('mkdir ' + ssh[:remote_path])
      systems.each do |sys_id|
        sys_name = PdsSyslist.find(sys_id).System.tr('/', '_')
        write_log('Генерация селект-файла для ' + sys_name + '.')
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
        if dbm_generator.systems_all?
          data_tot += data_sys
        elsif data_sys > ''
          file_name = 'pds_malf_' + sys_name + '.sel'
          create_file(file_name, enc, data_sys)
          session.scp.upload! @local_path, ssh[:remote_path] + file_name
          write_log('Файл ' + file_name + ' загружен на сервер.')
        end
      end
      if dbm_generator.systems_all?
        file_name = 'pds_malf_ALL.sel'
        create_file(file_name, enc, data_tot)
        session.scp.upload! @local_path, ssh[:remote_path] + file_name
        write_log('Файл ' + file_name + ' загружен на сервер.')
      end
    end
    write_log('Генерация завершена.')
    write_log('Файлы размещены в ' + ssh[:remote_path])
  end

  def render_sel_ped(dbm_generator)
    gen_tables = dbm_generator.systems
    data_tot = ''
    is_rus = dbm_generator.rus?(dbm_generator.project_id)
    enc = dbm_generator.project_encoding(dbm_generator.project_id)
    ssh = dbm_generator.project_ssh(dbm_generator.project_id)
    ssh[:remote_path] += 'gen_peds/'
    template_lodi = HwIosignaldef.where(memtype: %w[LO DI]).all.pluck(:ioname)
    template_aidi = HwIosignaldef.where(memtype: %w[AI DI]).all.pluck(:ioname)
    hw_ped = HwPed.first
    sig_def = {}
    hw_ped.signals.each do |sig_name|
      sig_def[sig_name] = HwIosignaldef.where(ioname: sig_name).pluck('ID')
    end
    write_log('Подключение к серверу: ' + ssh[:ip] + '.')
    Net::SSH.start(ssh[:ip], 'load', password: ssh[:pass]) do |session|
      session.exec!('mkdir ' + ssh[:remote_path])
      gen_tables.each do |table_id|
        tbl_name = Tablelist.find(table_id).table
        write_log('Генерация селект-файла для ' + tbl_name + '.')
        tbl = Object.const_get(tbl_name.classify)
        objects = tbl.where(Project: dbm_generator.project_id).includes(:system, hw_ic: [:pds_panel, pds_project_unit: [:unit], hw_ped: []]).to_a
        data_tbl = ''
        objects.each do |obj|
          hw_ic = obj.hw_ic
          hw_ped = hw_ic.hw_ped
          data_obj = ''
          if table_id.to_i == 4 # announciators
            path = 'sel_ped_announciators.sel.erb'
            data_obj = Tilt.new(TEMPLATE_PATH.join(path).to_s).render(
              ActionView::Base.new, dbm_generator.as_json.merge(hw_ic: hw_ic, hw_ped: hw_ped, obj: obj, is_rus: is_rus)
            )
          else
            hw_ped.signals.each do |sig_name|
              next unless hw_ped[sig_name].to_i > 0
              if template_lodi.include?(sig_name)
                path = 'sel_ped_lodi.sel.erb'
                global = template_aidi.include?(sig_name) ? 'di' : 'lo'
              else
                path = 'sel_ped_aoai.sel.erb'
                global = template_aidi.include?(sig_name) ? 'ai' : 'ao'
              end
              if hw_ped.gen_ext?
                sig_id = sig_def[sig_name]
                hw_iosignals = HwIosignal.where(pedID: hw_ped.id, signID: sig_id).order(:id).to_a
              else
                hw_iosignals = nil
              end
              data = Tilt.new(TEMPLATE_PATH.join(path).to_s).render(
                ActionView::Base.new, dbm_generator.as_json.merge(hw_ic: hw_ic, hw_ped: hw_ped, obj: obj, global: global, is_rus: is_rus, dim: hw_ped[sig_name].to_i, hw_iosignals: hw_iosignals)
              )
              data_obj += data
            end
          end
          data_tbl += data_obj
        end
        file_name = tbl_name + '.sel'
        create_file(file_name, enc, data_tbl)
        session.scp.upload! @local_path, ssh[:remote_path] + file_name
        write_log('Файл ' + file_name + ' загружен на сервер.')
      end
    end
    write_log('Генерация завершена.')
    write_log('Файлы размещены в ' + ssh[:remote_path])
  end

  def create_file(file_name, enc, data)
    @file_name = file_name
    @local_path = FILE_PATH + file_name
    File.open(@local_path, 'w:' + enc) do |f|
      f << data.encode(enc, invalid: :replace, undef: :replace, replace: '', universal_newline: true)
    end
  end

  def write_log(string)
    current_user.message += Time.now.strftime('%Y.%m.%d %H:%M:%S ') + string + '\n'
    current_user.save
  end
 



end
