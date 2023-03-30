Rails.application.routes.draw do
  get "/products" => "products#index"
  get "/product/:id" => "products#show"
end
