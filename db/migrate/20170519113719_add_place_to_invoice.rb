class AddPlaceToInvoice < ActiveRecord::Migration[5.0]
  def change
    add_column :invoices, :place, :string
  end
end
