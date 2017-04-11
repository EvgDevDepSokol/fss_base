class DisplaySystemsController < BaseController
  ACTIONS = %i[pds_ppca pds_ppcd pds_sd].freeze

  # уродливо, но ОООЧЕНЬ быстро. Было 35-38 секунд, стало 3-5 секунд!
  def pds_ppcas
    @data_list = PdsPpca
      .where(Project: project.ProjectID)
      .includes(:system, :pds_detector)
      .pluck('ppcID', 'pds_syslist.SystemID', 'pds_syslist.System',
             'Shifr', 'Key', 'identif',
             'Description', 'Description_EN',
             'L_lim', 'U_lim', 'Unit', 'nom',
             'pds_detectors.DetID', 'pds_detectors.tag')
    @data_list = @data_list.each.map do |e|
      e1 = {}
      e1['id']               = e[0]
      e1['system']           = { id: e[1], System: e[2] }
      e1['Shifr']            = e[3]
      e1['Key']              = e[4]
      e1['identif']          = e[5]
      e1['Description']      = e[6]
      e1['Description_EN']   = e[7]
      e1['L_lim']            = e[8]
      e1['U_lim']            = e[9]
      e1['Unit']             = e[10]
      e1['nom']              = e[11]
      e1['pds_detector']     = { id: e[12], tag: e[13] }
      e = e1
    end
  end

  def pds_ppcds
    @data_list = PdsPpcd
      .where(Project: project.ProjectID)
      .includes(:system, :pds_detector)
      .pluck('ppcdID', 'pds_syslist.SystemID', 'pds_syslist.System',
             'Shifr', 'Key', 'identif',
             'Description', 'Description_EN',
             'pds_detectors.DetID', 'pds_detectors.tag')
    @data_list = @data_list.each.map do |e|
      e1 = {}
      e1['id']               = e[0]
      e1['system']           = { System: e[2], id: e[1] }
      e1['Shifr']            = e[3]
      e1['Key']              = e[4]
      e1['identif']          = e[5]
      e1['Description']      = e[6]
      e1['Description_EN']   = e[7]
      e1['pds_detector']     = { id: e[8], tag: e[9] }
      e = e1
    end
  end

  def pds_sds
    @data_list = PdsSd
      .where(Project: project.ProjectID)
      .includes(:system)
      .order(:sys, :Numb)
      .pluck(:id, :SdTitle, :BlobObj, :Numb,
        :title_EN,
        'pds_syslist.SystemID', 'pds_syslist.System')
      .map do |e|
        {
          id: e[0],
          SdTitle: e[1],
          BlobObj: e[2],
          Numb: e[3],
          title_EN: e[4],
          system: {
            id: e[5],
            System: e[6]
          }
        }
      end
  end

  helper_method :table_header

  def table_header
    model_class.attribute_names.map { |attr| { property: attr, header: attr } }.to_json
  end
end
