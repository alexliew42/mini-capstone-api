class CartedproductsController < ApplicationController
  protect_from_forgery with: :null_session
  
  def create
    @cartedproduct = CartedProduct.new(
      user_id: current_user.id,
      product_id: params[:product_id],
      quantity: params[:quantity],
      order_id: nil,
      status: "carted"
    )
    @cartedproduct.save
    render :show
  end

  def index
    if current_user
      @cartedproducts = CartedProduct.where(user_id: current_user.id, status: "carted")
      render :index
    else
      render json: {message: "You must be logged in to view items in the shopping cart."}
    end
  end

  def destroy
    @cartedproduct = CartedProduct.find_by(id: params[:id])
    @cartedproduct.status = "removed"
    @cartedproduct.save
    render json: {message: "Successfully deleted"}
  end  
end
