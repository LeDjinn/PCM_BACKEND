class CreateRatios < ActiveRecord::Migration[7.0]
  def change
    create_table :ratios do |t|
      t.integer :dn
      t.float :tps_demandrinage, precision: 10, scale: 2
      t.float :ratio_ac, precision: 10, scale: 2
      t.float :ratio_rm, precision: 10, scale: 2

      t.timestamps
    end
  end
end
