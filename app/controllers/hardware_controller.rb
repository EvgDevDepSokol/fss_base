class HardwareController < BaseController

  ACTIONS = [ :hw_peds, :hw_wirelist, :pds_iomap, :hw_iosignaldefs,
    :hw_iosignals, :hw_devtypes, :hw_iosignaldim, :pds_panels]

  def hw_peds
    @data_list = HwPed.where(Project: project.ProjectID).
      includes(:hw_devtype)
  end

  def hw_wirelists
    @data_list = HwWirelist.where(Project: project.ProjectID).
      includes(hw_ped: [:hw_devtype], pds_panel: [])
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
