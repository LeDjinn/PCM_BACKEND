class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.text :address
      t.string :country
      t.string :email
      t.string :phone_number
      t.string :siret

      t.timestamps
    end
  end
end
