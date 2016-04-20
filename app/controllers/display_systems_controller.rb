class DisplaySystemsController < BaseController

  ACTIONS = [:pds_ppca, :pds_ppcd, :pds_sd]

  # todo: сделать разбиение запроса на части, а то долго отдается
  def pds_ppcas
    @data_list = PdsPpca.where(Project: project.ProjectID)
.includes(:system)
  end

  # todo: сделать разбиение запроса на части, а то долго отдается
  def pds_ppcds
    @data_list = PdsPpcd.where(Project: project.ProjectID)
.includes(:system)
  end

  def pds_sds
    @data_list = PdsSd.where(Project: project.ProjectID)
.includes(:system)
  end

#  def create
#    @pds_button = PdsButton.new permit_params
#
#    if @pds_button.save
#      format.json { render :show, status: :created, location: @pds_button }
#    else
#      format.json { render json: @pds_button.errors, status: :unprocessable_entity }
#    end
#  end
#
#  def update
#    Rails.logger.warn permit_params
#
#    if current_object.update permit_params
#
#      render json: {status: :ok, data: current_object.custom_hash}
#    else
#      render json: {errors: current_object.errors, data: current_object.reload.custom_hash},
#             status: :unprocessable_entity
#    end
#
#  rescue
#    render json: {errors: current_object.errors, data: current_object.reload.custom_hash},
#           status: :unprocessable_entity
#  end
#
#  def destroy
#    if current_object.destroy
#      render json: {}, head: :no_content
#    else
#      render json: {errors: []}, status: 403
#    end
#  end

  helper_method :table_header

  def table_header
    model_class.attribute_names.map{ |attr| {property: attr, header: attr}}.to_json
  end

end
