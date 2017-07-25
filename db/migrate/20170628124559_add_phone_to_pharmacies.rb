class AddPhoneToPharmacies < ActiveRecord::Migration[5.0]
  def change
    add_column :pharmacies, :phone, :string
  end
end
