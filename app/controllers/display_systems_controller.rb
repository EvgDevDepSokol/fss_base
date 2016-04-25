class DisplaySystemsController < BaseController

  ACTIONS = [:pds_ppca, :pds_ppcd, :pds_sd]

  # todo: сделать разбиение запроса на части, а то долго отдается
  # уродливо, но ОООЧЕНЬ быстро. Было 35-38 секунд, стало 3-5 секунд!
  def pds_ppcas
    @data_list = PdsPpca.where(Project: project.ProjectID)
.includes(:system).pluck("ppcID","pds_syslist.System","pds_syslist.SystemID","Shifr","Key","identif",
    "Description","Description_EN","Detector","L_lim","U_lim","Unit","nom")
    @data_list = @data_list.each.map{ |e|
      e1 = {}
      e1['id']               = e[0]
      e1['system']           = {System: e[1], id: e[2]}
      e1['Shifr']            = e[3]
      e1['Key']              = e[4]
      e1['identif']          = e[5]
      e1['Description']      = e[6]
      e1['Description_EN']   = e[7]
      e1['Detector']         = e[8]
      e1['L_lim']            = e[9]
      e1['U_lim']            = e[10]
      e1['Unit']             = e[11]
      e1['nom']              = e[12]
      e = e1 
    }
#.includes(:system)
  end

  # todo: сделать разбиение запроса на части, а то долго отдается
  def pds_ppcds
    @data_list = PdsPpcd.where(Project: project.ProjectID)
.includes(:system).pluck("ppcdID","pds_syslist.System","pds_syslist.SystemID","Shifr","Key","identif",
    "Description","Description_EN","Detector")
    @data_list = @data_list.each.map{ |e|
      e1 = {}
      e1['id']               = e[0]
      e1['system']           = {System: e[1], id: e[2]}
      e1['Shifr']            = e[3]
      e1['Key']              = e[4]
      e1['identif']          = e[5]
      e1['Description']      = e[6]
      e1['Description_EN']   = e[7]
      e1['Detector']         = e[8]
      e = e1 
    }
#.includes(:system)
  end

  def pds_sds
    @data_list = PdsSd.where(Project: project.ProjectID)
.includes(:system)
  end

  helper_method :table_header

  def table_header
    model_class.attribute_names.map{ |attr| {property: attr, header: attr}}.to_json
  end

end
