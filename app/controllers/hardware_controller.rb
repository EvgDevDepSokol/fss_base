class HardwareController < BaseController
  # Hardware controller
  ACTIONS = %i[hw_peds hw_wirelist pds_iomap hw_iosignaldefs
               hw_iosignals hw_devtypes hw_iosignaldim pds_panels].freeze

  def hw_peds
    @data_list = HwPed.where(Project: project.ProjectID)
                      .includes(:hw_devtype)
  end

  def hw_wirelists
    @data_list = HwWirelist.where(Project: project.ProjectID)
                           .includes(:hw_ic, :hw_ped, :pds_panel)
                           .pluck(
                             'wirelist_N', 'from', 'to', 'wc', 'nc', 'io', 'm', 's', 'word', 'bit',
                             'hw_peds.ped_N', 'hw_peds.ped',
                             'rev', 'remarks',
                             'pds_panel.pID', 'pds_panel.panel',
                             'hw_ic.icID', 'hw_ic.ref'
                           )

    @data_list = @data_list.each.map do |e|
      e1 = {}
      e1['id']        = e[0]
      e1['from']      = e[1]
      e1['to']        = e[2]
      e1['wc']        = e[3]
      e1['nc']        = e[4]
      e1['io']        = e[5]
      e1['m']         = e[6]
      e1['s']         = e[7]
      e1['word']      = e[8]
      e1['bit']       = e[9]
      e1['hw_ped']    = { id: e[10], ped: e[11] }
      e1['rev']       = e[12]
      e1['remarks']   = e[13]
      e1['pds_panel'] = { id: e[14], panel: e[15] }
      e1['hw_ic']     = { id: e[16], ref: e[17] }
      e = e1
    end
  end

  def pds_iomaps
    @data_list = PdsIomap.where(Project: project.ProjectID)
  end

  def hw_iosignaldefs
    @data_list = HwIosignaldef.all
  end

  def hw_iosignals
    @data_list = HwIosignal.where(Project: project.ProjectID)
                           .includes(:hw_ped, :hw_iosignaldef)
                           .order(:pedID, :signID, :id)
  end

  def hw_devtypes
    @data_list = HwDevtype.all.includes(:tablelist)
  end

  def hw_iosignaldims
    @data_list = HwIosignaldim.where(Project: project.ProjectID)
  end

  def pds_panels
    @data_list = PdsPanel.where(Project: project.ProjectID) # .includes(:hw_ped, :panel)
  end

  helper_method :table_header

  Oj.default_options = { mode: :compat }
  def table_header
    Oj.dump(model_class.attribute_names.map { |attr| { property: attr, header: attr } })
  end
end
