class AddPriceNalToPrice < ActiveRecord::Migration[5.0]
  def change
    add_column :prices, :price_nal, :decimal
  end
end
