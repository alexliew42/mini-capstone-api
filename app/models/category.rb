class Category < ApplicationRecord
  has_many :category_products
  has_many :products, through: :category_products

  # def products
  #   products = []
  #   @categoryproducts = CategoryProduct.all
  #   @categoryproducts.each do |categoryproduct|
      
  #   end
  # end
end
