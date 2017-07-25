module ProductsHelper
require 'csv'
require 'dbf'
  # Загружаем всю номенклатуру
  def getAllProducts
    widgets = DBF::Table.new("products.dbf", nil, 'cp866')
    widgets.each do |record|
      @p=Product.new
      @p.id = record.nnt
      @p.name = record.name
      @p.qtn = record.qnt
      @p.price = record.price
      @p.save
      puts record.name
      puts record.price
    end
  end

def impPrice
	widgets = DBF::Table.new("products.dbf", nil, 'cp866')   
	widgets.each do |record|
		if Product.where(:id => record.nnt).exists?
			p=Product.find_by_id(record.nnt)
			p.price=record.price
			p.price=record.price1
			p.ext_id=record.ext_id
			p.save
		else
		      @p=Product.new
		      @p.id = record.nnt
		      @p.name = record.name		      
		      @p.price = record.price
		      @p.price1=record.price1
		      @p.ext_id = record.ext_id
		      @p.save
		end  
	end
end

def importkls
    widgets = DBF::Table.new("KLScmp.dbf", nil, 'cp866')
    widgets.each do |record|     
       if Product.where(:id => record.cmp).exists?
          p = Product.find_by_id(record.cmp)
          p.group_id=record.kls
          p.save
       end                					
    end  
end

def impRLS
	CSV.foreach("RLS.csv",:quote_char => "\x00", encoding: "windows-1251",col_sep: ';', :headers => true) do |row|
#encoding: "bom|utf-8",                      :quote_char => "\x00",
#	CSV.foreach("RLS.csv", encoding: "bom|utf-8",row_sep: '\r\n',col_sep: ';', :quote_char => "\x00", :headers => false) do |row|
#	CSV.new(File.open('RLS.csv', 'r:bom|utf-8'), col_sep: ';').each do |row|
	 # r = row.split('\r\n');
          
          r = row.to_hash
#          puts r["ext_id"]
 		rl = Rl.new
		rl.ext_id = r["ext_id"]
		rl.mnn = r["mnn"]
		rl.composition = r["composition"]
		rl.indic = r["indic"]
		rl.unindic = r["unindic"] 
		rl.method = r["method"] 
		rl.limit = r["limit"]
		rl.overdose = r["overdose"] 
		rl.precaut = r["precaut"] 
		rl.pregnan = r["pregnan"] 		
		rl.sideact = r["sideact"] 
		rl.pharmact = r["pharmact"] 
		rl.pharmak = r["pharmak"]
		rl.pharmadynamic = r["pharmadynamic"]  
		rl.actonorg = r["actonorg"] 
		rl.compsprop = r["compsprop"] 
		rl.interaction = r["interaction"]
		rl.specguid = r["specguid"] 
		rl.charactres = r["charactres"] 
		rl.drugform = r["drugform"] 
		rl.clinic = r["clinic"] 
		rl.direct = r["direct"] 
		rl.inst = r["inst"] 
		rl.recomend = r["recomend"]
		rl.comment  = r["comment"]
		rl.manufact = r["manufact"] 
		rl.liter = r["liter"]
		rl.save

	end

end

end
