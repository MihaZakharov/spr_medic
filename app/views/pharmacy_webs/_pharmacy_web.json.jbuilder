json.extract! pharmacy_web, :id, :name, :director, :phone, :addres, :created_at, :updated_at
json.url pharmacy_web_url(pharmacy_web, format: :json)
