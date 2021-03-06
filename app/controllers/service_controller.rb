# frozen_string_literal: true

class ServiceController < BaseController
  # Service controller
  ACTIONS = [:tablelist, # :table_role_rights, :roles,
             :pds_project_properties, :pds_engineers, :pds_project,
             :pds_syslist, #:tblbinaries,
             :pds_unit, :pds_blocks,
             :pds_customers, :pds_negotiators, :sign_rpt,
             :audit, :pds_equips, :articles].freeze

  # helper_method :table_data, :table_header, :editable_properties, :model_class

  before_action :current_user_rights

  def tablelists
    @data_list = Tablelist.all
  end

  # def table_role_rights
  #   @data_list = TableRoleRight.includes(:role, :tablelist)
  # end

  # def roles
  #   @data_list = Role.all
  # end

  # TODO: не ясно нужно ли тут использовать скоуп проекта
  def pds_project_properties
    @data_list = PdsProjectProperty.where('ProjectID in (?)', PROJECT_LIST)
  end

  def pds_engineers
    @data_list = PdsEngineer.all
  end

  def pds_projects
    @data_list = PdsProject.where('ProjectID in (?)', PROJECT_LIST)
  end

  def pds_syslists
    @data_list = PdsSyslist.all
  end

  def tblbinaries
    @data_list = Tblbinary.limit(100)
  end

  def pds_units
    @data_list = PdsUnit.all
  end

  def pds_blocks
    @data_list = PdsBlock.where(Project: project.ProjectID).includes(:system)
  end

  def pds_customers
    @data_list = PdsCustomer.where(Project: project.ProjectID)
  end

  def pds_negotiators
    @data_list = PdsNegotiator.where(Project: project.ProjectID)
  end

  # TODO: no view
  def sign_rpts
    @data_list = SignRpt.all
  end

  def audits
    @data_list = Audit.where(Project: project.ProjectID).order(t: :desc)
  end

  def companies
    @data_list = Company.all
  end

  def pds_equips
    @data_list = PdsEquip.all
  end

  def articles
    @data_list = Article.order(t: :desc)
  end

  helper_method :table_header

  def table_header
    model_class.attribute_names.map { |attr| { property: attr, header: attr } }.to_json
  end

  private

  def current_user_rights
    if current_user.user_rights >= 3
      true
    else
      render html: '<strong>Не хватает прав для просмотра таблицы.</strong>'.html_safe
    end
  end
end
