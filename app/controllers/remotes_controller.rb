# frozen_string_literal: true

class RemotesController < BaseController
  # Remotes controller
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
                      .plucked
  end

  def pds_malfunction_dims
#byebug
    @data_list = PdsMalfunctionDim.where(Project: project.ProjectID)
                                  .includes(pds_malfunction: [:system]).ordered
                                  .includes(:sd_sys_numb)
                                  .plucked
  end
end
