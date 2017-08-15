class CreatePharmacyWebs < ActiveRecord::Migration[5.0]
  def change
    create_table :pharmacy_webs do |t|
      t.string :name
      t.string :director
      t.string :phone
      t.string :addres

      t.timestamps
    end
  end
end
