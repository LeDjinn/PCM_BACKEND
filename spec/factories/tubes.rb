FactoryBot.define do
  factory :tube do
    country { "export" }
    pressure { 13 }
    mat { "scr" }
    type_piece { "TUBE ORTHO" }
    dn { 2500 }
    ac { 3 }
    rm { 2 }
    quantity { 13 }
    price_mo { 10 }
    voile_ac { "1777lg 50 MM" }
    barear_ac { "RESINE EQUIVALENTE 470" }
    charge_ac { "CHARGE ANTI ABRASION" }
    resine_rm { "RESINE EQUIVALENTE 411" }
    charge_rm { "ANTI UV 326" }
    color { "PATE COLORANTE 7035" }
    number_voile_ac { 4 }
    association :quotation, factory: :quotation
  end

  
end
