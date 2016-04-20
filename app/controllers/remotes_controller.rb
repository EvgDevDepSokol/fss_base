class RemotesController < BaseController

  ACTIONS = [:pds_malfunction, :pds_malfunction_dim, :pds_rf]

  def pds_malfunctions
    @data_list = PdsMalfunction.where(Project: project.ProjectID).
      includes(:system, {pds_project_unit: :unit})
  end

  def pds_rves
    @data_list = PdsRf.where(Project: project.ProjectID).
      includes(:system, {pds_project_unit: :unit},{psa_project_unit: :unit})
  end

  def pds_malfunction_dims
    @data_list = PdsMalfunctionDim.where(Project: project.ProjectID)
  end

end
