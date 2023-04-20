class OrdersController < ApplicationController
  #before_action :authenticate_user
  def create
    @cart = CartedProduct.where(status: "carted", user_id: current_user.id)
    
    calculated_sub_total = 0
    @cart.each do |item|
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
    render json: {YourOrder: @order}

    # product = Product.find_by(id: params[:product_id])
    # calculated_subtotal = params[:quantity].to_i * product.price

    # calculated_tax = calculated_subtotal * 0.09
    # calculated_total = calculated_subtotal + calculated_tax
    # if current_user
    #   @order = Order.new(
    #     user_id: current_user.id,
    #     product_id: params[:product_id],
    #     quantity: params[:quantity],
    #     subtotal: calculated_subtotal,
    #     tax: calculated_tax,
    #     total: calculated_total
    #   )
    #   @order.save
    #   render json: {message: "Order created successfully!"}
    # else
    #   render json: {message: "You must be logged in to purchase this product!"}
    # end
  end

  def show
    @order = Order.find_by(id: params[:id])
    render :show
  end

  def index
    @orders = Order.all
    render :index
  end

end
