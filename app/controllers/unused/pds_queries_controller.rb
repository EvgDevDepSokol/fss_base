class PdsQueriesController < ApplicationController
  before_action :set_pds_query, only: [:show, :edit, :update, :destroy]

  # GET /pds_queries
  # GET /pds_queries.json
  def index
    @pds_queries = PdsQuery.all
  end

  # GET /pds_queries/1
  # GET /pds_queries/1.json
  def show
  end

  # GET /pds_queries/new
  def new
    @pds_query = PdsQuery.new
  end

  # GET /pds_queries/1/edit
  def edit
  end

  # POST /pds_queries
  # POST /pds_queries.json
  def create
    @pds_query = PdsQuery.new(pds_query_params)

    respond_to do |format|
      if @pds_query.save
        format.html { redirect_to @pds_query, notice: 'Pds query was successfully created.' }
        format.json { render :show, status: :created, location: @pds_query }
      else
        format.html { render :new }
        format.json { render json: @pds_query.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_queries/1
  # PATCH/PUT /pds_queries/1.json
  def update
    respond_to do |format|
      if @pds_query.update(pds_query_params)
        format.html { redirect_to @pds_query, notice: 'Pds query was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_query }
      else
        format.html { render :edit }
        format.json { render json: @pds_query.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_queries/1
  # DELETE /pds_queries/1.json
  def destroy
    @pds_query.destroy
    respond_to do |format|
      format.html { redirect_to pds_queries_url, notice: 'Pds query was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pds_query
      @pds_query = PdsQuery.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pds_query_params
      params.require(:pds_query).permit(:Project, :sys, :queryNumber, :query_make_date, :answer_expected_date, :query_essence, :engineer_N, :query_transfer_date, :answer_date, :answer_essence, :who_answered, :if_close, :Assumption, :t)
    end
end
