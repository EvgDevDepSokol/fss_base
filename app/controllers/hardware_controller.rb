class HardwareController < BaseController

  ACTIONS = [ :hw_peds, :hw_wirelist, :pds_iomap, :hw_iosignaldefs,
    :hw_iosignals, :hw_devtypes, :hw_iosignaldim, :pds_panels]

  def hw_peds
    @data_list = HwPed.where(Project: project.ProjectID).
      includes(:hw_devtype)
  end

  def hw_wirelists
    @data_list = HwWirelist.where(Project: project.ProjectID).
      includes(hw_ped: [:hw_devtype], pds_panel: []).
      pluck(
        "wirelist_N","from","to","wc","nc","io","m","s","word","bit",
        "hw_peds.ped_N","hw_devtype.typeID","hw_devtype.RuName",
        "rev","IC","remarks",
        "pds_panel.pID","pds_panel.panel")

    @data_list = @data_list.each.map{ |e|
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
      e1['hw_ped']    = {id: e[10], hw_devtype: {id: e[11], RuName: e[12]}}
      e1['rev']       = e[13]
      e1['IC']        = e[14]
      e1['remarks']   = e[15]
      e1['pds_panel'] = {id: e[16], panel: e[17]}
      e = e1
    }
  end

  def pds_iomaps
    @data_list = PdsIomap.where(Project: project.ProjectID)
  end

  def hw_iosignaldefs
    @data_list = HwIosignaldef.all
  end

  def hw_iosignals
    @data_list = HwIosignal.where(Project: project.ProjectID)
  end

  def hw_devtypes
    @data_list = HwDevtype.all
  end

  def hw_iosignaldims
    @data_list = HwIosignaldim.where(Project: project.ProjectID)
  end

  def pds_panels
    @data_list = PdsPanel.where(Project: project.ProjectID)#.includes(:hw_ped, :panel)
  end

  helper_method :table_header

  Oj.default_options = { :mode => :compat }
  def table_header
    Oj.dump(model_class.attribute_names.map{ |attr| {property: attr, header: attr}})
  end

end
