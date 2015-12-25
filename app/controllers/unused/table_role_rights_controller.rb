class TableRoleRightsController < ApplicationController
  before_action :set_table_role_right, only: [:show, :edit, :update, :destroy]

  # GET /table_role_rights
  # GET /table_role_rights.json
  def index
    @table_role_rights = TableRoleRight.all
  end

  # GET /table_role_rights/1
  # GET /table_role_rights/1.json
  def show
  end

  # GET /table_role_rights/new
  def new
    @table_role_right = TableRoleRight.new
  end

  # GET /table_role_rights/1/edit
  def edit
  end

  # POST /table_role_rights
  # POST /table_role_rights.json
  def create
    @table_role_right = TableRoleRight.new(table_role_right_params)

    respond_to do |format|
      if @table_role_right.save
        format.html { redirect_to @table_role_right, notice: 'Table role right was successfully created.' }
        format.json { render :show, status: :created, location: @table_role_right }
      else
        format.html { render :new }
        format.json { render json: @table_role_right.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /table_role_rights/1
  # PATCH/PUT /table_role_rights/1.json
  def update
    respond_to do |format|
      if @table_role_right.update(table_role_right_params)
        format.html { redirect_to @table_role_right, notice: 'Table role right was successfully updated.' }
        format.json { render :show, status: :ok, location: @table_role_right }
      else
        format.html { render :edit }
        format.json { render json: @table_role_right.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /table_role_rights/1
  # DELETE /table_role_rights/1.json
  def destroy
    @table_role_right.destroy
    respond_to do |format|
      format.html { redirect_to table_role_rights_url, notice: 'Table role right was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_table_role_right
      @table_role_right = TableRoleRight.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def table_role_right_params
      params.require(:table_role_right).permit(:tableID, :roleID, :value)
    end
end
