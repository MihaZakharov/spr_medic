class InvoiceMailer < ApplicationMailer
  default from: "mihail.zaharov84@mail.ru"
  layout "mailer"
  def mailer(invoice)
    @invoice = invoice
    @url = 'http://134.0.119.2/getinvoice/'+@invoice.id.to_s+'/edit'
    #@user = "mihail.zaharov84@mail.ru"
    @user = "mihail.zaharov84@mail.ru"

    @inv = Invoice.find_by_id(@invoice.id)

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

    mail(to: @user, subject: 'Поступил новый заказ')
  end

end
