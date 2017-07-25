class AddKlsToGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :kls_unicode, :integer
    add_column :groups, :kls_parent, :integer
  end
end
