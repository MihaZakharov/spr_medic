class ProductsController < ApplicationController
    before_action :authenticate_user
    skip_before_action :verify_authenticity_token

def getdetailproduct
   @hash = params[:id].to_json
   @p = Product.find_by_id(@hash["id"])
   render json: @p
end

  def showproductsfromgroup

      @grp = params[:id].to_s

      g = Group.find_by_id(@grp)
      res=[]
      buf={}
#      g.products.where("price1 > 0").order("name ASC").each do |prod|
      g.products.order("name ASC").each do |prod|
        buf = {}
	        buf[:name] = prod.name
	        buf[:id] = prod.id
	        buf[:price] = prod.price
	        buf[:ext_id] = prod.ext_id
	        buf[:group_id] = prod.group_id
          #buf[:prc] = prc_fact
          buf[:prc_f] = prod.price1
          buf[:prc_i] =  prod.price
          res.push(buf)
      end
#      render json: @pr_in_grp
      render json: res

  end

  def all

  end

  def dtlprod
     @par = params[:ext_id].to_json
     res = Rl.find_by_ext_id(@par)
     render json: res
  end

  def searching
     @par = params[:name].to_json
    # resp = Product.where(" to_tsvector('russian',name) @@ to_tsquery('russian',?)",@par)
    # if not resp.exists?
        #resp = Product.where(' similarity(name,?)>0.1',@par)
        resp =Product.connection.select_all('select name,id,min_prc,max_prc,cnt_pharmacies from public."GetMinMaxPricesAndOffers"(\''+@par+'\')')
     #end
     res=[]
     buf={}
     resp.each do |prod| #Проходим по всем найденным позициям, ищем цены
       buf={}
       prc_fact = 0
       prc_inv = 0
       #получаем минимальную цену
       #prc_fact = prod.prices.group('product_id').minimum('price')
       # Получаем максимальную цену
       #prc_inv = prod.prices.group('product_id').maximum('price')
       #получаем минимальную цену
       prc_fact = 0
       prc_inv = 0
  #     prc_fact = prod.prices.minimum('price')
       # Получаем максимальную цену
  #     prc_inv = prod.prices.maximum('price')
    #   if prc_inv != nil then
    #   if (prc_inv > 0) then
        buf[:name] = prod["name"]
        #buf[:name] = prod.name
        buf[:id] = prod["id"]
        buf[:cnt_pharmacies] = prod["cnt_pharmacies"]
        #buf[:price] = prod.price
        #buf[:ext_id] = prod.ext_id
        #buf[:group_id] = prod.group_id
        #buf[:prc] = prc_fact
        buf[:prc_f] = prod["min_prc"] #(prod.price1 + prod.price1*prc_fact/100).floor
        buf[:prc_i] = prod["max_prc"] #(prod.price +  prod.price*prc_inv/100).floor
        res.push(buf)
    #   end
    #   end
     end
     render json: res
  end

end
