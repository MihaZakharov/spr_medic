class AddPharmcyIdToInvoice < ActiveRecord::Migration[5.0]
  def change
    add_column :invoices, :pharmacy_id, :integer
  end
end
