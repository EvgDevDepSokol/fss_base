class ServiceController < BaseController

  ACTIONS = [ :tablelist, :table_role_rights, :roles,
    :pds_project_properties, :pds_engineers, :pds_project,
    :pds_syslist, :tblbinaries, :pds_unit, :pds_blocks,
    :pds_customers, :pds_negotiators, :sign_rpt,
    :audit, :company, :pds_equips, :articles]


  helper_method :table_data, :table_header, :editable_properties, :model_class

  def tablelists
    @data_list = Tablelist.all
  end

  def table_role_rights
    @data_list = TableRoleRight.all
  end

  def roles
    @data_list = Role.all
  end

  # todo: не ясно нужно ли тут использовать скоуп проекта
  def pds_project_properties
    @data_list = PdsProjectProperty.all
  end

  def pds_engineers
    @data_list = PdsEngineer.all
  end

  def pds_projects
    @data_list = PdsProject.all
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
    @data_list = PdsBlock.all
  end

  def pds_customers
    @data_list = PdsCustomer.all
  end

  def pds_negotiators
    @data_list = PdsNegotiator.all
  end

  # todo: no view
  def sign_rpts
    @data_list = SignRpt.all
  end

  def audits
    @data_list = Audit.limit(1000)
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

  def create
    @current_object = model_class.new permit_params

    if @current_object.save
      render json: { status: :created, data: current_object.reload.serializable_hash }
    else
      render json: { errors: @current_object.errors, status: :unprocessable_entity }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_pds_button
    @current_object = model.find(params[:id])
 end

  def current_object
    @current_object ||= model.find(params[:id])
  end

  def project
    @project ||= PdsProject.find(params[:pds_project_id]) if params[:pds_project_id]
  end

  def editable_properties
    if model_class.respond_to?(:editable_attributes)
      model_class.editable_attributes.to_json
    else
      model_class.attribute_names.reduce({}){ |hash, attr| hash.merge(
          attr => {type: model_class.columns_hash[attr].type,
                   title: attr})}.to_json
    end

  end

  def table_header
    if model_class.respond_to?(:view_columns)
      model_class.view_columns
    else
      model_class.attribute_names.map{ |attr| {property: attr, header: attr}}.to_json
    end
  end

end
