class SpecialOfferController < ApplicationController
  before_action :authenticate_user
  skip_before_action :verify_authenticity_token

  def getSpecialOffer
    res=[]
    buf={}

     SpecialOffer.find_each  do |p|
      buf={}
      pname = Product.find_by_id(p.id).name
      phname = Pharmacy.find_by_id(p.pharmacy_id).name
      buf[:name] = pname
      buf[:price1] = p.price1.floor
      buf[:prt_currQnt] = p.prt_currQnt
      buf[:pharmacy] = phname
      buf[:date_god] = p.date_god
      buf[:ext_id] = p.ext_id
      res.push(buf)
    end
    render json: res
  end

  def getOffersFromApt
    #Контроллер для получения предложений по аптекам
    res = []
    buf = {}
    params.require(:product).permit(:product_id,:region_id)
    @par=params[:product].to_json
    @hash = JSON.parse(@par)
    p=Product.find_by_id(@hash["product_id"])
    p.prices.each do |product|
      buf={}
      #Получаю название аптеки и цены
      if Pharmacy.where('id=:p',{p:product["pharmacy_id"]}).exists?
          buf[:price_nal] = product["price_nal"]
          buf[:product_id] = product["product_id"]
          buf[:product_name] = p.name
          buf[:price] = product["price"]
          buf[:pharmacy_id] = product["pharmacy_id"]
          pharm = Pharmacy.find_by_id(product["pharmacy_id"])
          buf[:pharmacy] = pharm.name
          buf[:pharm_adress] = pharm.adress
          buf[:pharm_region_id] = pharm.region_id
          buf[:pharm_timeopen] = pharm.timeopen
          buf[:pharm_phone] = pharm.phone
          buf[:pharm_region] = Region.find_by_id(pharm.region_id).name
          puts  @hash["region_id"]
          puts  pharm.region_id
          if (@hash["region_id"].to_s == pharm.region_id.to_s) then
            res.push(buf)
          elsif (@hash["region_id"] == "all") then
            res.push(buf)
          end
      end
    end
    render json: res
  end


end
