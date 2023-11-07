class CreateQuotations < ActiveRecord::Migration[7.0]
  def change
    create_table :quotations do |t|
      t.belongs_to :company, null: false, foreign_key: true
    

      t.timestamps
    end
  end
end
