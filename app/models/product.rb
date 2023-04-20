class Product < ApplicationRecord
  belongs_to :supplier
  has_many :images
  has_many :orders
  has_many :category_products
  has_many :categories, through: :category_products
  has_many :carted_products

  validates :name, presence: true, uniqueness: true
  validates :description, length: {in: 5..300}

  

  def is_discounted?
    if price <= 10
      return true
    else
      return false
    end
  end
  
  def tax
    tax = price.to_f * 0.09
    return tax.round(2)
  end

  def total
    total = tax + price
    return total
  end


end
