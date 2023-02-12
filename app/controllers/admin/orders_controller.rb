class Admin::OrdersController < ApplicationController
  # def index
  #   @orders = Order.where(customer_id: params[:id])
  #   @customer = Customer.find(params[:id])
  # end

  def show
  end

  def one_person
    @customer = Customer.find(params[:id])
    # @orders = Order.where(customer_id: params[:id])
    # @order_amounts = @orders.amount
    @tests = Item.where(genre_id: 2)
  end

end
