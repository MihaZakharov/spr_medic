class InvoiceMailer < ApplicationMailer
  default from: "tfk.ru"
  layout "mailer"
  def mailer(invoice)
    @invoice = invoice
    @url = 'http://134.0.119.2/getinvoice/'+@invoice.id.to_s+'/edit'
    @user = "mihail.zaharov84@mail.ru"
    mail(to: @user, subject: 'Поступил новый заказ')
  end

end
