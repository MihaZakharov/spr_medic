module GroupsHelper
  #��������� ��� �������������
  def getAllGroups
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

def refKlsCmp
  res=[]
  r={}
	CSV.foreach("klscmp.csv",:quote_char => "\x00", encoding: "windows-1251",col_sep: ',', :headers => true) do |row|
    r = {}
    r = row.to_hash
#    rr[:cmp] = r["cmp"]
#    rr[:kls] = r["kls"]
if Product.where("id = :p",{p:r["cmp"]}).exists?
      @p=Product.find_by_id(r["cmp"])
      @g=Group.find_by_id(r["kls"])
      if @p != nil and @g != nil
         @p.groups<<@g
         @p.save
      end
end

#    res.push(r)
  end

#  res.each { |k|
#    if Product.where("id = :p",{p:k[:cmp]}).exists?
#          @p=Product.find_by_id(k[:cmp])
##          if @p != nil and @g != nil
  #           @p.groups<<@g
#             @p.save
#          end
#    end
#  }
end

  def getkls    # ������ ������ ��������� � ��������������

    widgets = DBF::Table.new("klscmp.dbf", nil, 'cp866')
    res=[]
    buf={}
    widgets.each do |record|
      buf={}
      buf[:cmp] = record.cmp
      buf[:kls] = record.kls
      res.push(buf)
#      @p=Product.find_by_id(record.cmp)
#      @g=Group.find_by_id(record.kls)
#      if @p != nil and @g != nil
#         @p.groups<<@g
#      end
#      @p.save
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

  end


  def getGrp
        @groups = Group.where('kls_parent=1613').each do |grp|
 		if grp.products.exists?
                    puts grp.products
                end
        end
  end
end
