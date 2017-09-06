class SpecialOfferController < ApplicationController
  protect_from_forgery with: :exception
  include Knock::Authenticable
  undef_method :current_user


    skip_before_action :verify_authenticity_token
    before_action :authenticate_user

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
    params.require(:product).permit(:product_id,:region_id,:val)
    @par=params[:product].to_json
    @hash = JSON.parse(@par)
    p=Product.find_by_id(@hash["product_id"])
    p.prices.each do |product| #Выгребаем абсолютно все предложения аптек
      buf={}
      #'id=:p',{p:product["pharmacy_id"]}
      if @hash["val"] == nil # если пользователь ничего не искал, то показываем все предложения аптекам и по региону
        @where = 'id=' + product["pharmacy_id"].to_s
#      else
#        @where = " to_tsvector('russian',name) @@ to_tsquery('russian','"+@hash["val"].to_s+"')"
      puts "val is not nil"
      #Получаю название аптеки и цены
          if Pharmacy.where(@where).exists? # Если у любой аптеки есть цена
              puts 'price'
              puts product["price_nal"]
              if product["price_nal"] != nil then
                buf[:price_nal] = product["price_nal"].round
              else
                buf[:price_nal] = '0'
              end
              buf[:product_id] = product["product_id"]
              buf[:product_name] = p.name
              buf[:price] = product["price"].round
              buf[:pharmacy_id] = product["pharmacy_id"]
              pharm = Pharmacy.find_by_id(product["pharmacy_id"])
              buf[:pharmacy] = pharm.name
              buf[:pharm_adress] = pharm.adress
              buf[:pharm_region_id] = pharm.region_id
              buf[:pharm_timeopen] = pharm.timeopen
              buf[:pharm_phone] = pharm.phone
              buf[:pharm_region] = Region.find_by_id(pharm.region_id).name
              if (@hash["region_id"].to_s == pharm.region_id.to_s) then
                res.push(buf)
              elsif (@hash["region_id"] == "all") then
                res.push(buf)
              #elsif (@hash["val"] != "") then
              #  res.push(buf)
              end
          end # если у любой аптеки есть цена
      end  # если пользователь ничего не искал, то показываем все предложения апте

  end #Выгребаем абсолютно все предложения аптек

  if @hash["val"] != nil #Пользователь вел поиск по аптеке
    puts "try find"
    #@where =
     p.prices.where('pharmacy_id in (:pharm_id)',{pharm_id: Pharmacy.where(' similarity(name,?)>0.25', @hash["val"].to_s).map{ |pr| pr.id}}).each do |product| # поиск цен
       buf={}
        puts 'price'
        puts product["price_nal"]
        if product["price_nal"] != nil then
          buf[:price_nal] = product["price_nal"].round
        else
          buf[:price_nal] = '0'
        end
        buf[:product_id] = product["product_id"]
        buf[:product_name] = p.name
        buf[:price] = product["price"].round
        buf[:pharmacy_id] = product["pharmacy_id"]
        pharm = Pharmacy.find_by_id(product["pharmacy_id"])
        buf[:pharmacy] = pharm.name
        buf[:pharm_adress] = pharm.adress
        buf[:pharm_region_id] = pharm.region_id
        buf[:pharm_timeopen] = pharm.timeopen
        buf[:pharm_phone] = pharm.phone
        buf[:pharm_region] = Region.find_by_id(pharm.region_id).name
        res.push(buf)

   end # поиск цен
 end #Пользователь вел поиск по аптеке

    render json: res
  end


end
