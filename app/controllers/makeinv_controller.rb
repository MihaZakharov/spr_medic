class MakeinvController < ApplicationController
  protect_from_forgery with: :exception
  include Knock::Authenticable
  undef_method :current_user

  skip_before_action :verify_authenticity_token
  before_action :authenticate_user

  rescue_from "Exception", :with => :show_errors


   def all

      params.require(:invoice).permit(:inv,:summ_i,:summ_n,:place,:phone,:status,:email,:number, items: [:is_nal,:goodsid,:price,:product_name,:qnt,:pharmacy_id,:pharmacy_name,:price,:price1])

      @par=params[:invoice].to_json
      @hash = JSON.parse(@par)

      data=@hash["items"]
      puts '!!!!!!!'
      puts data
      pharm = data[0]["pharmacy_id"]
      puts '?????'
      begin
      (0..data.length-1).each do |i|
         if pharm != data[i]["pharmacy_id"]
           raise 'ExceptionMoreTwoPharm'
         end
         pharm = data[i]["pharmacy_id"]
      end
      rescue
        puts "I am in rescue"
        render json:  "В заказе указано больше двух аптек. Заказ не может быть оформлен" , :status => 500
        return false
      end
      puts '!!!!!!!!!'
      inv = Invoice.new
      inv.phone_invoice=@hash["phone"]
      inv.status=@hash["status"]
      inv.email=@hash["email"]
      inv.place=@hash["place"]
      inv.summ=@hash["summ_i"]
      inv.summ_n=@hash["summ_n"]
      inv.inv = @hash["inv"]
      inv.user_id = current_user.id

      #puts res.sort_by { |hsh| hsh[:pharmacy_id] }
      Invoice.transaction do
          #(0..@hash["items"].length-1).each do |i|
          (0..data.length-1).each do |i|
            #Создаем новый заказ
              items=Item.new
              @goodsid=data[i]["goodsid"]
              @price=data[i]["price"]
              @price1=data[i]["price1"]
              @qnt=data[i]["qnt"]
              inv.pharmacy_id = data[i]["pharmacy_id"]
              items.goodsid=@goodsid
              items.price=@price
              items.price1=@price1
              items.qnt=@qnt
              inv.items << items
              inv.save

          end # loop
          begin
            @user = 'mihail.zaharov84@mail.ru'
            users = ['mihail.zaharov84@mail.ru'] #
            users.push(@user)
            users.each do |ma|
              puts 'try to send'
              InvoiceMailer.mailer(inv,ma).deliver_now
              puts 'sended'
            end
          rescue Exception
            ActiveRecord::Rollback
            raise Exception
          end
      end # translation

   end # end proc

   def show_errors
       #raise ActiveRecord::Rollback, "Call tech support!"
       puts 'what a fuck'
       render json:  "Что то пошло не так. Отправка почты сорвалась, заказ не был оформлен" , :status => 500
   end


# {"invoice":{"phone":922705538, "email":"mihail.zaharov84@mail.ru", "status":"new",
#             "items": [{"goodsid":12423,"price":32,"qnt":1},
#                           {"goodsid":123,"price":12,"qnt":2}]
#
#            }
#  }

end
