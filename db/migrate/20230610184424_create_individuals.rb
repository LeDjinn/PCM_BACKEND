class CreateIndividuals < ActiveRecord::Migration[7.0]
  def change
    create_table :individuals do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone_number
      t.belongs_to :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
