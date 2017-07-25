class ProductsController < ApplicationController
    skip_before_filter :verify_authenticity_token

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
      g.products.where("price1 > 0").order("name ASC").each do |prod|
	       buf={}
         prc_fact = 0
         prc_inv = 0
         # Если товар есть в группе, которая участвует в ценообразовании, то берем цену из назначенной группы
         if Percentage.where("val_fact_2 >= :p and val_fact_1 < :p and group_id in (:grp_id)",{p: prod.price,grp_id: prod.groups.map{ |pr| pr.id}}).exists?
           #Так как товар принадлежит к куче групп, проверяем, его группы есть ли в системе ценообразования
           Percentage.where("val_fact_2 >= :p and val_fact_1 < :p and group_id in (:grp_id)",{p: prod.price,grp_id: prod.groups.map{ |pr| pr.id}}).each do |prc|
               prc_fact = prc.percent_fact
               prc_inv = prc.percent_inv
           end
         end
         #Если не нашли группы, то шарим по всей номенклатуре и определяем цену
         if (prc_fact == 0) or (prc_inv == 0) then
           if Percentage.where("val_fact_2 >= :p and val_fact_1 < :p",{p: prod.price}).exists?
             prcnt = Percentage.where("val_fact_2 >= :p and val_fact_1 < :p",{p: prod.price}).last
             prc_fact = prcnt.percent_fact
             prc_inv = prcnt.percent_inv
           end
         end

	        buf[:name] = prod.name
	        buf[:id] = prod.id
	        buf[:price] = prod.price
	        buf[:ext_id] = prod.ext_id
	        buf[:group_id] = prod.group_id
          buf[:prc] = prc_fact
          buf[:prc_f] =  (prod.price1 + prod.price1*prc_fact/100).floor
          buf[:prc_i] =  (prod.price +  prod.price*prc_inv/100).floor
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
     resp = Product.where("price1>0 and to_tsvector('russian',name) @@ to_tsquery('russian',?)",@par)
     if not resp.exists?
        resp = Product.where('price1>0 and similarity(name,?)>0.1',@par)
     end
     res=[]
     buf={}
     resp.each do |prod| #Проходим по всем найденным позициям, ищем цены
       buf={}
       prc_fact = 0
       prc_inv = 0
       # Если товар есть в группе, которая участвует в ценообразовании, то берем цену из назначенной группы
       if Percentage.where("val_fact_2 >= :p and val_fact_1 < :p and group_id in (:grp_id)",{p: prod.price,grp_id: prod.groups.map{ |pr| pr.id}}).exists?
         #Так как товар принадлежит к куче групп, проверяем, его группы есть ли в системе ценообразования
         Percentage.where("val_fact_2 >= :p and val_fact_1 < :p and group_id in (:grp_id)",{p: prod.price,grp_id: prod.groups.map{ |pr| pr.id}}).each do |prc|
             prc_fact = prc.percent_fact
             prc_inv = prc.percent_inv
         end
       end
       #Если не нашли группы, то шарим по всей номенклатуре и определяем цену
       if (prc_fact == 0) or (prc_inv == 0) then
         if Percentage.where("val_fact_2 >= :p and val_fact_1 < :p",{p: prod.price}).exists?
           prcnt = Percentage.where("val_fact_2 >= :p and val_fact_1 < :p",{p: prod.price}).last
           prc_fact = prcnt.percent_fact
           prc_inv = prcnt.percent_inv
         end
       end

        buf[:name] = prod.name
        buf[:id] = prod.id
        buf[:price] = prod.price
        buf[:ext_id] = prod.ext_id
        buf[:group_id] = prod.group_id
        buf[:prc] = prc_fact
        buf[:prc_f] =  (prod.price1 + prod.price1*prc_fact/100).floor
        buf[:prc_i] =  (prod.price +  prod.price*prc_inv/100).floor
        res.push(buf)

     end
     render json: res
  end

end
