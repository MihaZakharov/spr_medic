class CreateSpecialOffers < ActiveRecord::Migration[5.0]
  def change
    create_table :special_offers do |t|
      t.decimal :price1
      t.integer :prt_currQnt
      t.integer :pharmacy_id
      t.string :date_god
      t.integer :ext_id

      t.timestamps
    end
  end
end
