class AddPrice1ToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :price1, :decimal
  end
end
