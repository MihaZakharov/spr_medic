class GetinvoiceController < ApplicationController

    #skip_before_action :verify_authenticity_token
    before_filter :authenticate_user!,only: [:index,:change,:edit]
    #protect_from_forgery with: :exception
    #include Knock::Authenticable
    #undef_method :current_user

    #before_action :finduser
    #before_action :authenticate_api,only: [:showinv]



def index
       #Получаем все заказы для пользователя, который закреплен за одной или нескольких аптек

  #      current_user =  User.find_by_authentication_token(params[:authenticity_token])
       if params[:fltr] == "3" then
          @inv = Invoice.all.where("status = '3' and pharmacy_id in (:ph_id)",ph_id: Pharmacy.where('user_id=:p',p:current_user.id).map{ |ph| ph.id })
          #@inv = Invoice.all.where("status = '3'")
          @status = "Отгруженные"
        elsif params[:fltr] == "4"
          @inv = Invoice.all.where("status = '4'  and pharmacy_id in (:ph_id)",ph_id: Pharmacy.where('user_id=:p',p:current_user.id).map{ |ph| ph.id })
          #@inv = Invoice.all.where("status = '2'").order("status DeSC")
          @status = "Отказ"
        elsif params[:fltr] == "2"
          @inv = Invoice.all.where("status = '2'  and pharmacy_id in (:ph_id)",ph_id: Pharmacy.where('user_id=:p',p:current_user.id).map{ |ph| ph.id })
          #@inv = Invoice.all.where("status = '2'").order("status DeSC")
          @status = "В работе"
        else
          @inv = Invoice.all.where("status not in ('2','3','4') and pharmacy_id in (:ph_id)",ph_id: Pharmacy.where('user_id=:p',p:current_user.id).map{ |ph| ph.id })
          #@inv = Invoice.all.where("status not in ('2','3')").order("status DeSC")
          @status = "Новые"
       end

   #render json: @user
end

def change
  p = params[:id]
  invoice = Invoice.find_by_id(p)
  invoice.status = params[:value]

  invoice.save
  @inv_number = invoice.id

  @inv = Invoice.all
  render "new.html.erb"

end

def edit
   @p = params[:id].to_s

   @inv = Invoice.find_by_id(@p)

   res=[]
   buf={}
   @inv.items.each do |dtl|
     p=Product.find_by_id(dtl.goodsid)
     buf = {}
     buf[:name] = p.name
     buf[:qnt] = dtl.qnt
     buf[:price] = dtl.price
     buf[:price1] = dtl.price1
     res.push(buf)
   end
   @dtlinv = res
  # @inv = Invoice.all
end





  private

  def authenticate_api
  #  protect_from_forgery with: :exception
    #undef_method :current_user
  end

#http://localhost:3000/getinvoice/

#{"invoices":{"phone":"23423","email":"235","code":"123"}}

#{"invoices":{"number_invoice":65}}
end
