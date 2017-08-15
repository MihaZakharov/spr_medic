class CreatePriceAvas < ActiveRecord::Migration[5.0]
  def change
    create_table :price_avas do |t|
      t.integer :cmp_u
      t.decimal :price
      t.integer :qnt

      t.timestamps
    end
  end
end
