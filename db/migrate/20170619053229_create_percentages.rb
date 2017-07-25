class CreatePercentages < ActiveRecord::Migration[5.0]
  def change
    create_table :percentages do |t|
      t.decimal :val_fact_1
      t.decimal :val_fact_2
      t.decimal :percent_fact
      t.decimal :val_inv_1
      t.decimal :val_inv_2
      t.decimal :percent_inv
      t.integer :group_id

      t.timestamps
    end
  end
end
