class GetInvoiceApiController < ApplicationController

  protect_from_forgery with: :exception
  include Knock::Authenticable
  undef_method :current_user


    skip_before_action :verify_authenticity_token
    before_action :authenticate_user,only: [:showinv]

  def showinv
     params.require(:invoices).permit(:phone,:code,:email)
     @par = params[:invoices].to_json
     @hash = JSON.parse(@par)
     @phone = @hash["phone"]
     @email = @hash["email"]
     res=[]
     buf={}
     #Invoice.all.where("user_id = :user_id and email = :email AND phone_invoice = :phone",email: @email, phone: @phone, user_id: current_user.id).each do |inv|
     Invoice.all.where("user_id = :user_id and status = :st",{st: @hash["fltr_inv"],user_id: current_user.id}).each do |inv|
 buf={}

 buf[:email] = inv.email
 buf[:id] = inv.id
 if inv.inv == 1
   buf[:summ] = inv.summ
 else
   buf[:summ] = inv.summ_n
 end
 if inv.status == "new"
   buf[:status] = "Новый"
 elsif inv.status == "1"
   buf[:status] = "Просмотрен"
 elsif inv.status == "2"
   buf[:status] = "Обработан"
 elsif inv.status == "3"
   buf[:status] = "Отгружен"
 elsif inv.status == "4"
   buf[:status] = "Отказ"
 end
 buf[:place] = inv.pharmacy.name
 buf[:updated_at] = inv.updated_at.to_s(:db)

 res.push(buf)
     end
     render  json: res

  end

 def showdetailinvoice
         res=[]
         buf={}
         params.require(:invoices).permit(:number_invoice)
   @par = params[:invoices].to_json
   @hash = JSON.parse(@par)
   @number_invoice = @hash["number_invoice"]
   inv = Invoice.find_by_id(@number_invoice)
#		items = inv.items
   hash = {}
   inv.items.each do |prod|
     buf = {}
     name_prod = Product.find_by_id(prod.goodsid)
     buf[:name] = name_prod.name
     buf[:goodsid] = prod.goodsid
     buf[:price] = prod.price
     buf[:qnt] = prod.qnt
     res.push(buf)
   end
   render json: res
 end
end
