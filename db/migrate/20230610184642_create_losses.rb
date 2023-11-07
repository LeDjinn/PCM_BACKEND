class CreateLosses < ActiveRecord::Migration[7.0]
  def change
    create_table :losses do |t|
      t.integer :dn
      t.float :lenght_useful, precision: 10, scale: 2
      t.float :loss_orhto, precision: 10, scale: 2
      t.float :loss_helico, precision: 10, scale: 2

      t.timestamps
    end
  end
end
