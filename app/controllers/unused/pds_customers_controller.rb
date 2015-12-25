class PdsCustomersController < ApplicationController
  before_action :set_pds_customer, only: [:show, :edit, :update, :destroy]

  # GET /pds_customers
  # GET /pds_customers.json
  def index
    @pds_customers = PdsCustomer.all
  end

  # GET /pds_customers/1
  # GET /pds_customers/1.json
  def show
  end

  # GET /pds_customers/new
  def new
    @pds_customer = PdsCustomer.new
  end

  # GET /pds_customers/1/edit
  def edit
  end

  # POST /pds_customers
  # POST /pds_customers.json
  def create
    @pds_customer = PdsCustomer.new(pds_customer_params)

    respond_to do |format|
      if @pds_customer.save
        format.html { redirect_to @pds_customer, notice: 'Pds customer was successfully created.' }
        format.json { render :show, status: :created, location: @pds_customer }
      else
        format.html { render :new }
        format.json { render json: @pds_customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_customers/1
  # PATCH/PUT /pds_customers/1.json
  def update
    respond_to do |format|
      if @pds_customer.update(pds_customer_params)
        format.html { redirect_to @pds_customer, notice: 'Pds customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_customer }
      else
        format.html { render :edit }
        format.json { render json: @pds_customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_customers/1
  # DELETE /pds_customers/1.json
  def destroy
    @pds_customer.destroy
    respond_to do |format|
      format.html { redirect_to pds_customers_url, notice: 'Pds customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pds_customer
      @pds_customer = PdsCustomer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pds_customer_params
      params.require(:pds_customer).permit(:Project, :AgreeName, :t, :AgreeJobTitle, :AgreeJobTitle_EN, :AcceptedName1, :AcceptedJobTitle1, :AcceptedJobTitle1_EN, :AcceptedName2, :AcceptedJobTitle2, :AcceptedJobTitle2_EN, :Name)
    end
end
