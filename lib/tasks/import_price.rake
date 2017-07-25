#require 'config/environment'
require 'csv'
require 'dbf'
namespace :utils do

  desc "import price and creating goods if not exists"
  task :import_price  => :environment do

    widgets = DBF::Table.new("Products.dbf", nil, 'cp866')
    widgets.each do |record|
      if Product.where(:id => record.nnt).exists?
        p=Product.find_by_id(record.nnt)
        #p.price=record.price
        p.price1=record.price1
        p.ext_id=record.ext_id
        p.save
      else
            @p=Product.new
            @p.id = record.nnt
            @p.name = record.name
            #@p.price = record.price
            @p.price1=record.price1
            @p.ext_id = record.ext_id
            @p.save
      end #end if
    end # end loop

    res=[]
    rr={}
  	CSV.foreach("klscmp.csv",:quote_char => "\x00", encoding: "windows-1251",col_sep: ',', :headers => true) do |row|
      rr = {}
      r = row.to_hash
  #    rr[:cmp] = r["cmp"]
  #    rr[:kls] = r["kls"]
      res.push(rr)
    end
    res.each { |k|
      if Product.where("id = :p",{p:k[:cmp]}).exists?
            @p=Product.find_by_id(k[:cmp])
            @g=Group.find_by_id(k[:kls])
            if @p != nil and @g != nil
               @p.groups<<@g
               @p.save
            end
      end
    }

  end #task import_price

  desc "import Pharmacies"
  task :import_pharmacies => :environment do
    widgets = DBF::Table.new("Pharmacies.dbf", nil, 'cp866')
    widgets.each do |record|
      if Pharmacy.where(:id => record.id).exists?
        @p=Pharmacy.find_by_id(record.id)
        @p.name = record.name
        @p.phone = record.phone
        @p.adress = record.adress
        @p.description = record.descriptio
        @p.save
      else
        @p=Pharmacy.new
        @p.id = record.id
        @p.name = record.name
        @p.phone = record.phone
        @p.adress = record.adress
        @p.description = record.descriptio
        @p.save
      end
  end
end # import_price

desc "import Offers"
task :import_offers => :environment do
  widgets = DBF::Table.new("Offers.dbf", nil, 'cp866')
  SpecialOffer.destroy_all
  widgets.each do |record|
      @p=SpecialOffer.new
      @p.id = record.nnt
      @p.price1 = record.price1
      @p.prt_currQnt = record.prt_qnt
      @p.pharmacy_id = record.pharmacy_i
      @p.date_god = record.date_god
      @p.ext_id = record.ext_id
      @p.save
end
  puts "all records was imported"
end # import_offers

desc "import cmp"
task :import_cmp => :environment do
  CSV.foreach("CMP.csv",:quote_char => "\x00",col_sep: ';', :headers => true) do |row| # encoding: "windows-1251",
    r = row.to_hash
    if not Product.where(:id => r["nnt"]).exists?
      @p=Product.new
      @p.id = r["nnt"]
      @p.name = r["name"]
      #@p.price = r["price"]
      #@p.price1=r["price1"]
      @p.ext_id = r["ext_id"]
      @p.save
    end #if exit
  end # foreach
end # impor_cmp

desc "import price ex"
task :import_price_ex  => :environment do
  widgets = DBF::Table.new("price.dbf", nil, 'cp866')
  widgets.each do |record|
    if Product.where(:id => record.cmp_u).exists?
      p=Product.find_by_id(record.cmp_u)
    #  puts "update nnt" + record.cmp_u.to_s
      p.price=record.price1
      p.save
    end #if
  end # foreach
end # price ex


end
