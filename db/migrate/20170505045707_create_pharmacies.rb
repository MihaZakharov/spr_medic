class CreatePharmacies < ActiveRecord::Migration[5.0]
  def change
    create_table :pharmacies do |t|
      t.string :name
      t.text :description
      t.string :adress

      t.timestamps
    end
  end
end
