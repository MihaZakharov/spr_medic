class CreateRls < ActiveRecord::Migration[5.0]
  def change
    create_table :rls do |t|
      t.text :mnn
      t.text :composition
      t.text :indic
      t.text :unindic
      t.text :method
      t.text :limit
      t.text :overdose
      t.text :precaut
      t.text :pregnan
      t.text :text
      t.text :sideact
      t.text :pharmact
      t.text :pharmak
      t.text :actonorg
      t.text :compsprop
      t.text :specguid
      t.text :charactres
      t.text :drugform
      t.text :clinic
      t.text :direct
      t.text :inst
      t.text :recomend
      t.text :comment
      t.text :manufact
      t.text :liter

      t.timestamps
    end
  end
end
