class AddTimeopenToParmacies < ActiveRecord::Migration[5.0]
  def change
    add_column :pharmacies, :timeopen, :string
  end
end
