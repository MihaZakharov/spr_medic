class CreatePrices < ActiveRecord::Migration[5.0]
  def change
    create_table :prices do |t|
      t.decimal :price
      t.integer :product_id
      t.integer :pharmacy_id

      t.timestamps
    end
  end
end
