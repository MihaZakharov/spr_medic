class PercentagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_percentage, only: [:show, :edit, :update, :destroy]

  # GET /percentages
  # GET /percentages.json
  def index
    @percentages = Percentage.all.order("group_id,val_fact_1,val_inv_1")
  end

  # GET /percentages/1
  # GET /percentages/1.json
  def show
  end

  # GET /percentages/new
  def new
    @percentage = Percentage.new
  end

  def newex
    @p = params[:id]
    puts @p
    @percentage = Percentage.new
    @percentage.pharmacy_id = @p
    render 'new'
  end

  # GET /percentages/1/edit
  def edit
  end

  # POST /percentages
  # POST /percentages.json
  def create
    @percentage = Percentage.new(percentage_params)

    respond_to do |format|
      if @percentage.save
        format.html { redirect_to @percentage, notice: 'Percentage was successfully created.' }
        format.json { render :show, status: :created, location: @percentage }
      else
        format.html { render :new }
        format.json { render json: @percentage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /percentages/1
  # PATCH/PUT /percentages/1.json
  def update
    respond_to do |format|
      if @percentage.update(percentage_params)
        format.html { redirect_to @percentage, notice: 'Percentage was successfully updated.' }
        format.json { render :show, status: :ok, location: @percentage }
      else
        format.html { render :edit }
        format.json { render json: @percentage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /percentages/1
  # DELETE /percentages/1.json
  def destroy
    @percentage.destroy
    respond_to do |format|
      format.html { redirect_to percentages_url, notice: 'Percentage was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_percentage
      @percentage = Percentage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def percentage_params
      params.require(:percentage).permit(:val_fact_1, :val_fact_2, :percent_fact, :val_inv_1, :val_inv_2, :percent_inv, :group_id, :pharmacy_id)
    end
end
