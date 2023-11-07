class CreateMatters < ActiveRecord::Migration[7.0]
  def change
    create_table :matters do |t|
      t.string :name
      t.float :price_local, precision: 10, scale: 2
      t.float :price_export, precision: 10, scale: 2
      t.belongs_to :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
