class ProjectSettingsController < BaseController

  ACTIONS = [:pds_eng_on_sys, :pds_project_unit, :pds_doc_on_sys,
             :pds_project_sys, :week_report, :pds_documents,
             :pds_documentation, :pds_simplifications, :pds_queries,
             :pds_sys_description, :pds_dr, :pds_mathmodel].freeze

  def pds_eng_on_sys
    @data_list = PdsEngOnSy.where(Project: project.ProjectID)
                           .includes(:pds_engineer, :pds_engineer_test, :system)
  end

  def pds_project_units
    @data_list = PdsProjectUnit.where(Project: project.ProjectID).includes(:unit)
  end

  def pds_doc_on_sys
    @data_list = PdsDocOnSy.where.not(sys: nil)
                           .includes(:pds_documentation).where(pds_documentation: { Project: project.ProjectID })
                           .includes(:system)
  end

  def pds_project_sys
    @data_list = PdsProjectSy.where(Project: project.ProjectID).includes(:system)
  end

  def week_reports
    @data_list = WeekReport.where(Project: project.ProjectID)
                           .includes(:pds_engineer, :system)
  end

  def pds_documents
    @data_list = PdsDocument.where(Project: project.ProjectID)
                            .includes(:pds_engineer, :working_engineer_ru, :working_engineer_en)
  end

  def pds_documentations
    @data_list = PdsDocumentation.where(Project: project.ProjectID)
  end

  def pds_simplifications
    @data_list = PdsSimplification.where(Project: project.ProjectID)
                                  .includes(:pds_query, :system)
                                  .order(:sys, :Numb)
  end

  def pds_sys_descriptions
    @data_list = PdsSysDescription.where(Project: project.ProjectID).includes(:system)
  end
end
