class Company < ApplicationRecord
    has_many :individuals, dependent: :destroy
end
