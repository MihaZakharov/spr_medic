class SpecialOfferController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def getSpecialOffer
    res=[]
    buf={}

     SpecialOffer.find_each  do |p|
      buf={}
      pname = Product.find_by_id(p.id).name
      phname = Pharmacy.find_by_id(p.pharmacy_id).name
      buf[:name] = pname
      buf[:price1] = p.price1.floor
      buf[:prt_currQnt] = p.prt_currQnt
      buf[:pharmacy] = phname
      buf[:date_god] = p.date_god
      buf[:ext_id] = p.ext_id
      res.push(buf)
    end
    render json: res
  end

end
