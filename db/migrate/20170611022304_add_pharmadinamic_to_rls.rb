class AddPharmadinamicToRls < ActiveRecord::Migration[5.0]
  def change
    add_column :rls, :pharmadynamic, :text
  end
end
