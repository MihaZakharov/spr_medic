class AddPharmacyIdToPercentages < ActiveRecord::Migration[5.0]
  def change
    add_column :percentages, :pharmacy_id, :integer
  end
end
