class OrdersController < ApplicationController
  before_action :authenticate_user
  
  def create
    cart = CartedProduct.where(status: "carted", user_id: current_user.id)
    
    calculated_sub_total = 0
    cart.each do |item|
      price = Product.find_by(id: item.product_id).price * item.quantity
      calculated_sub_total += price
      item.status = "purchased"
    end
    
    tax = calculated_sub_total * 0.09
    calculated_total = calculated_sub_total + tax
    @order = Order.new(
      user_id: current_user.id,
      subtotal: calculated_sub_total,
      tax: tax,
      total: calculated_total,
    )
    @order.save

    cart.update_all(order_id: @order.id)
    render :show
  end

  def show
    @order = Order.find_by(id: params[:id])
    render :show
  end

  def index
    if current_user
      @orders = Order.where(user_id: current_user.id)
      render :index
    else
      render json: {message: "You must be logged in to view!"}
    end
  end

end
