json.extract! customer, :id, :name, :email, :departament, :created_at, :updated_at
json.url customer_url(customer, format: :json)
