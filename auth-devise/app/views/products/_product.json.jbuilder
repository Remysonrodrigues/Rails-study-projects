json.extract! product, :id, :description, :quantity, :created_at, :updated_at
json.url product_url(product, format: :json)
