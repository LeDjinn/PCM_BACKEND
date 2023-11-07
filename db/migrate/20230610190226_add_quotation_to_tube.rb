class AddQuotationToTube < ActiveRecord::Migration[7.0]
  def change
    add_reference :tubes, :quotation, null: false, foreign_key: true
  end
end
