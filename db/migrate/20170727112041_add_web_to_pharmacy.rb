class AddWebToPharmacy < ActiveRecord::Migration[5.0]
  def change
    add_column :pharmacies, :pharmacy_web_id, :integer
  end
end
