class CreateInvoices < ActiveRecord::Migration[5.0]
  def change
    create_table :invoices do |t|
      t.integer :number_invoice
      t.string  :phone_invoice
      t.timestamps
    end
  end
end
