# json.extract! product, :id, :created_at, :updated_at
# json.url product_url(product, format: :json)

json.id product.id
json.name product.name
json.price product.price
json.image_url product.image_url
json.description product.description
json.created_at product.created_at
json.updated_at product.updated_at



#"id", "name", "price", "image_url", "description", "created_at", "updated_at"