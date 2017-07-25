class AddSummNToInvoice < ActiveRecord::Migration[5.0]
  def change
    add_column :invoices, :summ_n, :decimal
  end
end
