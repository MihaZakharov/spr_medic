class AddExtidToRls < ActiveRecord::Migration[5.0]
  def change
    add_column :rls, :ext_id, :integer
  end
end
