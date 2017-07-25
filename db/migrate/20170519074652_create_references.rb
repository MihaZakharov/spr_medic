class CreateReferences < ActiveRecord::Migration[5.0]
  def change
    create_table :groups_products do |t|
      t.integer :product_id, index: true
      t.integer :group_id, index: true
    end
  end
end
