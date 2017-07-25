class AddExtidToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :ext_id, :integer
  end
end
