class AddRegionIdToPharmacy < ActiveRecord::Migration[5.0]
  def change
    add_column :pharmacies, :region_id, :integer
  end
end
