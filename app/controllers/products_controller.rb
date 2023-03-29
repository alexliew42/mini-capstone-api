class ProductsController < ApplicationController
  def computer
    @product = Product.find_by(name: "Computer")
    render template: "products/show"
  end
end
