class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.integer :goodsid
      t.float :price
      t.integer :qnt
      t.integer :invoice_id
      t.timestamps
    end
  end
end
