json.extract! company, :id, :name, :address, :country, :email, :phone_number, :siret, :created_at, :updated_at
json.url company_url(company, format: :json)
