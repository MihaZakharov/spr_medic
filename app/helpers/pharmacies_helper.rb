module PharmaciesHelper
  def getPharmacies
    widgets = DBF::Table.new("Pharmacies.dbf", nil, 'cp866')
    widgets.each do |record|
      if Pharmacy.where(:id => record.id).exists?
        @p=Pharmacy.find_by_id(record.id)
        @p.name = record.name
        @p.phone = record.phone
        @p.adress = record.adress
        @p.description = record.descriptio
        @p.pharmacy_web_id = record.web
        @p.region_id = record.reg
        @p.save
        puts record.name
      else
        @p=Pharmacy.new
        @p.id = record.id
        @p.name = record.name
        @p.phone = record.phone
        @p.adress = record.adress
        @p.description = record.descriptio
        @p.pharmacy_web_id = record.web
        @p.region_id = record.reg
        @p.save
        puts record.phone
      end
    end
  end

def uppharm
#  @p = Pharmacy.all
#  @p.each do |pharm|
#    pharm.timeopen = "8.00 - 10.00"
#    pharm.save
#  end
end
end
