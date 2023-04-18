class OrdersController < ApplicationController
  def create
    product = Product.find_by(id: params[:product_id])
    calculated_subtotal = params[:quantity].to_i * product.price

    calculated_tax = calculated_subtotal * 0.09
    calculated_total = calculated_subtotal + calculated_tax
    if current_user
      @order = Order.new(
        user_id: current_user.id,
        product_id: params[:product_id],
        quantity: params[:quantity],
        subtotal: calculated_subtotal,
        tax: calculated_tax,
        total: calculated_total
      )
      @order.save
      render json: {message: "Order created successfully!"}
    else
      render json: {message: "You must be logged in to purchase this product!"}
    end
  end

  def show
    if current_user.id == order.user_id
      @order = Order.find_by(id: params[:id])
      render :show
    else
      render json: {message: "You must log in to see these products!"}
    end
  end

  def index
    if current_user.id == order.user_id
      @orders = Order.all
      render :index
    else
      render json: {message: "You must log in to see these products!"}
    end
  end

end
