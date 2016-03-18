class RemotesController < BaseController

  ACTIONS = [:pds_malfunction, :pds_rf, :pds_malfunction_dim]

  def pds_malfunctions
    @data_list = PdsMalfunction.where(Project: project.ProjectID)
  end

  def pds_rfs
    @data_list = PdsRf.where(Project: project.ProjectID)
  end

  def pds_malfunction_dims
    @data_list = PdsMalfunctionDim.where(Project: project.ProjectID)
  end

end
