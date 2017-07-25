class AddPriceToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :price1, :decimal
  end
end
