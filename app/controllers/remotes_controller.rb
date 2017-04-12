class RemotesController < BaseController
  ACTIONS = %i[pds_malfunction pds_malfunction_dim pds_rf].freeze

  def pds_malfunctions
    @data_list = PdsMalfunction.where(Project: project.ProjectID)
                               .includes(:system, pds_project_unit: :unit)
                               .includes(:sd_sys_numb)
                               .order(:sys, :Numb)
  end

  def pds_rves
    @data_list = PdsRf.where(Project: project.ProjectID)
                      .includes(:system, { pds_project_unit: :unit }, psa_project_unit: :unit)
                      .includes(:sd_sys_numb)
                      .pluck(:rfID, :name, :Ptag, :tag_RU, :Desc, :Desc_EN, :range, :type, :range_FB,
                        :Type_FB,
                        'pds_syslist.SystemID', 'pds_syslist.System',
                        'pds_project_unit.ProjUnitID', 'pds_unit.UnitID', 'pds_unit.Unit_RU',
                        'psa_project_units_pds_rf.ProjUnitID', 'units_pds_project_unit.UnitID', 'units_pds_project_unit.Unit_RU',
                        'sd_sys_numb.sd_N', 'sd_sys_numb.sd_link')
    @data_list = @data_list.each.map do |e|
      e1 = {}
      e1['id']               = e[0]
      e1['name']             = e[1]
      e1['Ptag']             = e[2]
      e1['tag_RU']           = e[3]
      e1['Desc']             = e[4]
      e1['Desc_EN']          = e[5]
      e1['range']            = e[6]
      e1['type']             = e[7]
      e1['range_FB']         = e[8]
      e1['Type_FB']          = e[9]
      e1['system']           = { id: e[10], System: e[11] }
      e1['pds_project_unit'] = { id: e[12], unit: { id: e[13], Unit_RU: e[14] } }
      e1['psa_project_unit'] = { id: e[15], unit: { id: e[16], Unit_RU: e[17] } }
      e1['sd_sys_numb']      = { id: e[18], sd_link: e[19] }
      e = e1
    end
  end

  def pds_malfunction_dims
    @data_list = PdsMalfunctionDim.where(Project: project.ProjectID)
                                  .includes(pds_malfunction: [:system]).ordered
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
      e1['system'] = { id: e[6], System: e[7] }
      e = e1
    end
  end
end
