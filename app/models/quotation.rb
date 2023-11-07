class Quotation < ApplicationRecord
  belongs_to :company
  has_many :tubes
end
