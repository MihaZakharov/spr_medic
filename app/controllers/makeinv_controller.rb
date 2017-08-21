class MakeinvController < ApplicationController
    before_action :authenticate_user
    skip_before_action :verify_authenticity_token

   def all



      params.require(:invoice).permit(:inv,:summ_i,:summ_n,:place,:phone,:status,:email,:number, items: [:goodsid,:price,:name,:qnt,:pharmacy_id])

      @par=params[:invoice].to_json

      @hash = JSON.parse(@par)
      inv = Invoice.new
      inv.phone_invoice=@hash["phone"]
      inv.status=@hash["status"]
      inv.email=@hash["email"]
      inv.place=@hash["place"]
      inv.summ=@hash["summ_i"]
      inv.summ_n=@hash["summ_n"]
      inv.inv = @hash["inv"]
      (0..@hash["items"].length-1).each do |i|
          items=Item.new
          @goodsid=@hash["items"][i]["goodsid"]
          @price=@hash["items"][i]["price"]
          @price1=@hash["items"][i]["price1"]
          @qnt=@hash["items"][i]["qnt"]
          inv.pharmacy_id = @hash["items"][i]["pharmacy_id"]
          items.goodsid=@goodsid
          items.price=@price
          items.price1=@price1
          items.qnt=@qnt
          inv.items << items
          inv.save
      end
      InvoiceMailer.mailer(inv).deliver_later

      render body: @par
   end



# {"invoice":{"phone":922705538, "email":"mihail.zaharov84@mail.ru", "status":"new",
#             "items": [{"goodsid":12423,"price":32,"qnt":1},
#                           {"goodsid":123,"price":12,"qnt":2}]
#
#            }
#  }

end
