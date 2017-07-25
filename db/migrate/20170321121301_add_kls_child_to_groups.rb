class AddKlsChildToGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :kls_childcount, :integer
  end
end
