class PharmacyWebsController < ApplicationController
  before_action :set_pharmacy_web, only: [:show, :edit, :update, :destroy]

  # GET /pharmacy_webs
  # GET /pharmacy_webs.json
  def index
    @pharmacy_webs = PharmacyWeb.all
  end

  # GET /pharmacy_webs/1
  # GET /pharmacy_webs/1.json
  def show
  end

  # GET /pharmacy_webs/new
  def new
    @pharmacy_web = PharmacyWeb.new
  end

  # GET /pharmacy_webs/1/edit
  def edit
  end

  # POST /pharmacy_webs
  # POST /pharmacy_webs.json
  def create
    @pharmacy_web = PharmacyWeb.new(pharmacy_web_params)

    respond_to do |format|
      if @pharmacy_web.save
        format.html { redirect_to @pharmacy_web, notice: 'Pharmacy web was successfully created.' }
        format.json { render :show, status: :created, location: @pharmacy_web }
      else
        format.html { render :new }
        format.json { render json: @pharmacy_web.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pharmacy_webs/1
  # PATCH/PUT /pharmacy_webs/1.json
  def update
    respond_to do |format|
      if @pharmacy_web.update(pharmacy_web_params)
        format.html { redirect_to @pharmacy_web, notice: 'Pharmacy web was successfully updated.' }
        format.json { render :show, status: :ok, location: @pharmacy_web }
      else
        format.html { render :edit }
        format.json { render json: @pharmacy_web.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pharmacy_webs/1
  # DELETE /pharmacy_webs/1.json
  def destroy
    @pharmacy_web.destroy
    respond_to do |format|
      format.html { redirect_to pharmacy_webs_url, notice: 'Pharmacy web was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pharmacy_web
      @pharmacy_web = PharmacyWeb.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pharmacy_web_params
      params.require(:pharmacy_web).permit(:name, :director, :phone, :addres)
    end
end
