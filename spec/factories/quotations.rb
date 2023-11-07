FactoryBot.define do
  factory :quotation do
    association :company, factory: :company

  end
end
