class PharmaciesController < ApplicationController
  before_action :set_pharmacy, only: [:show, :edit, :update, :destroy]


  def all
    @pharm = Pharmacy.all
    render json: @pharm
  end

  # GET /@Pharmacys
  # GET /@Pharmacys.json
  def index
    @pharmacies = Pharmacy.all
  end

  # GET /@Pharmacys/1
  # GET /@Pharmacys/1.json
  def show

  end

  # GET /@Pharmacys/new
  def new
    @pharmacy = Pharmacy.new
  end

  # GET /@Pharmacys/1/edit
  def edit
  end

  # POST /@Pharmacys
  # POST /@Pharmacys.json
  def create
    @pharmacy = Pharmacy.new(pharmacy_params)

    respond_to do |format|
      if @pharmacy.save
        format.html { redirect_to @pharmacy, notice: '@Pharmacy was successfully created.' }
        format.json { render :show, status: :created, location: @pharmacy }
      else
        format.html { render :new }
        format.json { render json: @pharmacy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /@Pharmacys/1
  # PATCH/PUT /@Pharmacys/1.json
  def update
    respond_to do |format|
      if @pharmacy.update(pharmacy_params)
        format.html { redirect_to @pharmacy, notice: '@Pharmacy was successfully updated.' }
        format.json { render :show, status: :ok, location: @pharmacies }
      else
        format.html { render :edit }
        format.json { render json: @pharmacy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /@Pharmacys/1
  # DELETE /@Pharmacys/1.json
  def destroy
    @pharmacy.destroy
    respond_to do |format|
      format.html { redirect_to pharmacy_url, notice: 'Pharmacy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pharmacy
      @pharmacy = Pharmacy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pharmacy_params
      params.require(:pharmacy).permit(:name,:region_id,:region,:pharmacy_web_id,:user_id)
    end
#,:timeopen,:pharmcy_web_id,:adress,:description,:status,:phone
end
