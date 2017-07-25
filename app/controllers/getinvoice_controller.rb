class GetinvoiceController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :authenticate_user!,only: [:index,:change,:edit]

def index
   if params[:fltr] == "3" then
      @inv = Invoice.all.where("status = '3'")
      @status = "Отгруженные"
    elsif params[:fltr] == "2"
      @inv = Invoice.all.where("status = '2'").order("status DeSC")
      @status = "В работе"
    else
      @inv = Invoice.all.where("status not in ('2','3')").order("status DeSC")
      @status = "Новые"
   end

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



   def showinv
      params.require(:invoices).permit(:phone,:code,:email)
      @par = params[:invoices].to_json
      @hash = JSON.parse(@par)
      @phone = @hash["phone"]
      @email = @hash["email"]
      res=[]
      buf={}
      Invoice.all.where("email = :email AND phone_invoice = :phone",email: @email, phone: @phone).each do |inv|
	buf={}
	buf[:email] = inv.email
	buf[:id] = inv.id
  if inv.inv == 1
    buf[:summ] = inv.summ
  else
    buf[:summ] = inv.summ_n
  end

	buf[:status] = inv.status
	buf[:place] = inv.place
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

#http://localhost:3000/getinvoice/

#{"invoices":{"phone":"23423","email":"235","code":"123"}}

#{"invoices":{"number_invoice":65}}
end
