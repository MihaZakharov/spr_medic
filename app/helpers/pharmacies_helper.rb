module PharmaciesHelper
  def getPharmacies
    widgets = DBF::Table.new("Pharmacies.dbf", nil, 'cp866')
    widgets.each do |record|
      @p=Pharmacy.new
      @p.name = record.name
      @p.adress = record.adress
      @p.description = record.descriptio
      @p.save
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