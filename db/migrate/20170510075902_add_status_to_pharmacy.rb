class AddStatusToPharmacy < ActiveRecord::Migration[5.0]
  def change
    add_column :pharmacies, :status, :string
  end
end
