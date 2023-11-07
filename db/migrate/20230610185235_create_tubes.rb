class CreateTubes < ActiveRecord::Migration[7.0]
  def change
    create_table :tubes do |t|
      t.string :country
      t.integer :pressure
      t.string :mat
      t.string :type_piece
      t.integer :dn
      t.float :ac , precision: 10, scale: 2
      t.float :rm, precision: 10, scale: 2
      t.integer :quantity
      t.integer :price_mo
      t.string :voile_ac
      t.string :barear_ac
      t.string :charge_ac
      t.string :resine_rm
      t.string :charge_rm
      t.string :color
      t.integer :number_voile_ac

      t.timestamps
    end
  end
end
