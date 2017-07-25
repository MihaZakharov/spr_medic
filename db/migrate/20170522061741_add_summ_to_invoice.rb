class AddSummToInvoice < ActiveRecord::Migration[5.0]
  def change
    add_column :invoices, :summ, :float
  end
end
