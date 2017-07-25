class AddEmailToInvoice < ActiveRecord::Migration[5.0]
  def change
    add_column :invoices, :email, :string
  end
end
