#require 'config/environment'
require 'csv'
require 'dbf'
namespace :utils do

  desc "import goods if not exists"
  task :import_goods  => :environment do

    widgets = DBF::Table.new("Products.dbf", nil, 'cp866')
    widgets.each do |record|
      if Product.where(:id => record.nnt).exists?
        p=Product.find_by_id(record.nnt)
        #p.price=record.price
        #p.price1=record.price1
        p.ext_id=record.ext_id
        p.save
      else
            @p=Product.new
            @p.id = record.nnt
            @p.name = record.name
            #@p.price = record.price
            #@p.price1=record.price1
            @p.ext_id = record.ext_id
            @p.save
      end #end if
    end # end loop

    res=[]
    rr={}
  	CSV.foreach("klscmp.csv",:quote_char => "\x00", encoding: "windows-1251",col_sep: ',', :headers => true) do |row|
      r = {}
      r = row.to_hash
  #    rr[:cmp] = r["cmp"]
  #    rr[:kls] = r["kls"]
      res.push(r)
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

desc "import products and groups references"
task :import_prod_groups_ref => :environment do
#  CSV.foreach("CMP.csv",:quote_char => "\x00",col_sep: ';', :headers => true) do |row| # encoding: "windows-1251",
#    r = row.to_hash
#    if not Product.where(:id => r["nnt"]).exists?
#      @p=Product.new
#      @p.id = r["nnt"]
#      @p.name = r["name"]
##      @p.price1=r["price1"]
#      @p.ext_id = r["ext_id"]
#      @p.save
#    end #if exit
#  end # foreach

  res=[]
  rr={}
  CSV.foreach("klscmp.csv",:quote_char => "\x00", encoding: "windows-1251",col_sep: ',', :headers => true) do |row|
    rr = {}
    r = {}
    r = row.to_hash
    rr[:cmp] = r["cmp"]
    rr[:kls] = r["kls"]
#     puts r["cmp"]
#     puts r["kls"]
    res.push(rr)
  end
  puts "add all to hash"
  puts "begin import"
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


end # impor_cmp

desc "import price ex"
task :import_price_ex  => :environment do
  widgets = DBF::Table.new("price.dbf", nil, 'cp866')
  widgets.each do |record|
    if Product.where(:id => record.cmp_u).exists?
      #find all pharmacies
      p=Pharmacy.all
      p.each  do |phr|
        price=Price.new
        price.price = record.price1
        price.pharmacy_id = phr.id
        price.product_id = record.cmp_u
        price.save
      end # all pharmacies
    end #if exists
  end # foreach
end # price ex

desc "import groups"
task :import_groups  => :environment do
    widgets = DBF::Table.new("kls.dbf", nil, 'cp866')
    widgets.each do |record|
      @p=Group.new
      @p.name = record.name
      @p.kls_unicode = record.kls_unicod
      @p.id = record.kls_unicod
      @p.kls_parent = record.kls_parent
      @p.kls_childcount = record.kls_childc
      @p.save
    end
end

desc "import price AVA svodni zakaz"
task :import_price_ava  => :environment do
  #widgets = DBF::Table.new("price.dbf", nil, 'cp866')
  #  PriceAva.find_by_sql("delete from price_avas")
  puts 'Cleared'
  puts 'begin insert all offers'
  #widgets.each do |record|
  #  if (record.cmp_u > 0) then
  #    pr=PriceAva.new
  #    pr.cmp_u=record.cmp_u
  #    pr.price=record.price1
  #    pr.qnt=record.qnt
  #    pr.save
  #  end #if
  #end # for each
  puts 'inserted all offers'
  puts 'get min prices and insert or update'
  PriceAva.find_by_sql('SELECT public."UpdatePriceEx"(\'price_avas\',1);');
  puts 'all prices was update'
end # price ex

end
