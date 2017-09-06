class AddUserIdToPharmacy < ActiveRecord::Migration[5.0]
  def change
    add_column :pharmacies, :user_id, :integer
  end
end
