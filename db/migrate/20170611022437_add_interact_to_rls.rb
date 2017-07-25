class AddInteractToRls < ActiveRecord::Migration[5.0]
  def change
    add_column :rls, :interaction, :text
  end
end
