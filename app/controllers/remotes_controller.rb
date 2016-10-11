class RemotesController < BaseController
  ACTIONS = [:pds_malfunction, :pds_malfunction_dim, :pds_rf].freeze

  def pds_malfunctions
    @data_list = PdsMalfunction.where(Project: project.ProjectID)
                               .includes(:system, pds_project_unit: :unit)
                               .includes(:sd_sys_numb)
  end

  def pds_rves
    @data_list = PdsRf.where(Project: project.ProjectID)
                      .includes(:system, { pds_project_unit: :unit }, psa_project_unit: :unit)
                      .includes(:sd_sys_numb)
  end

  def pds_malfunction_dims
    @data_list = PdsMalfunctionDim.where(Project: project.ProjectID)
                                  .includes(pds_malfunction: [:system])
                                  .includes(:sd_sys_numb)
                                  .pluck(
                                    :MalfunctDimID, :Character, :Target, :Target_EN, :is_main,
                                    'pds_malfunction.MalfID', 'pds_syslist.SystemID', 'pds_syslist.System', 'pds_malfunction.Numb',
                                    'sd_sys_numb.sd_N', 'sd_sys_numb.sd_link'
                                  )
    @data_list = @data_list.each.map do |e|
      e1 = {}
      e1['id']               = e[0]
      e1['Character']        = e[1]
      e1['Target']           = e[2]
      e1['Target_EN']        = e[3]
      e1['is_main']          = e[4]
      e1['pds_malfunction']  = { id: e[5], system: { id: e[6], System: e[7] }, Numb: e[8] }
      e1['sd_sys_numb'] = { id: e[9], sd_link: e[10] }
      e1['system']           = { id: e[6], System: e[7] }
      e = e1
    end
  end
end
