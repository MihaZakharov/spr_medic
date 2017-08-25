class ProductsController < ApplicationController
    #before_action :authenticate_user
    skip_before_action :verify_authenticity_token

def getdetailproduct
   @hash = params[:id].to_json
   @p = Product.find_by_id(@hash["id"])
   render json: @p
end

  def showproductsfromgroup

      @hash = params[:catid]

    #  g = Group.find_by_id(@grp)
      res=[]
      buf={}
#      g.products.where("price1 > 0").order("name ASC").each do |prod|
      #g.products.order("name ASC").each do |prod|
      #@p = @hash["catid"]
      @fun = 'select name,id,min_prc,max_prc,cnt_pharmacies from public."GetMinMaxPricesFromGroup"('+@hash+')';
      #@fun = @p
      #buf[:fname] = @fun
      #res.push(buf)
      resp =Product.connection.select_all(@fun)
      resp.each do |prod|
        buf = {}
	        #buf[:ext_id] = prod["ext_id"]
          buf[:product_name] = prod["name"]
          buf[:id] = prod["id"]
          buf[:cnt_pharmacies] = prod["cnt_pharmacies"]
          buf[:prc_min] = 0
          buf[:prc_max] = 0
          buf[:prc_min] = prod["min_prc"] #(prod.price1 + prod.price1*prc_fact/100).floor
          buf[:prc_max] = prod["max_prc"] #(prod.price +  prod.price*prc_inv/100).floor
          res.push(buf)
      end
#      render json: @pr_in_grp
      render json: res

  end

  def index
    @products=Product.limit(100)
  end

  def dtlprod
     @par = params[:ext_id].to_json
     res = Rl.find_by_ext_id(@par)
     render json: res
  end

  def searching
     @par = params[:name].to_s
    # resp = Product.where(" to_tsvector('russian',name) @@ to_tsquery('russian',?)",@par)
    # if not resp.exists?
        #resp = Product.where(' similarity(name,?)>0.1',@par)
        resp =Product.connection.select_all('select name,id,min_prc,max_prc,cnt_pharmacies from public."GetMinMaxPricesAndOffers"(\''+@par+'\')')
        puts @par
     #end
     res=[]
     buf={}
     resp.each do |prod| #Проходим по всем найденным позициям, ищем цены
        buf={}

        buf[:product_name] = prod["name"]

        buf[:id] = prod["id"]
        buf[:cnt_pharmacies] = prod["cnt_pharmacies"]
        buf[:prc_min] = 0
        buf[:prc_max] = 0
        buf[:prc_min] = prod["min_prc"] #(prod.price1 + prod.price1*prc_fact/100).floor
        buf[:prc_max] = prod["max_prc"] #(prod.price +  prod.price*prc_inv/100).floor
        res.push(buf)
    #   end
    #   end
     end
     render json: res
  end

end
