class Product < ApplicationRecord
  belongs_to :supplier
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
