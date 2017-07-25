class PharmaciesController < ApplicationController
 
  def all
    @pharm = Pharmacy.all
    render json: @pharm
  end

end
