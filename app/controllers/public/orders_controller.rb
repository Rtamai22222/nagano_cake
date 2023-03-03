class Public::OrdersController < ApplicationController

# before_action :check_imput, only: [:confirm]

  def new
    @order = Order.new
    cart_items = CartItem.where(customer_id: current_customer.id)
    total_price = CartItem.calculate_total_price(cart_items)
    @shipping_cost = 800
    @total_payment = total_price + @shipping_cost
    @checked = false
    @addresses = Address.where(customer_id: current_customer.id)
  end

  def index
    @order = Order.where(customer_id: current_customer.id)
    @order_details = OrderDetail.all
  end

  def show
    @order = Order.find(params[:id])
    @items = OrderDetail.where(order_id: params[:id])
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      cart_items = CartItem.where(customer_id: current_customer.id)
      cart_items.each do |itemlist|
        order_detail = OrderDetail.new
        order_detail.order_id = @order.id
        order_detail.item_id = itemlist.item.id
        order_detail.price = itemlist.item.price
        order_detail.amount = itemlist.amount
        order_detail.making_status = 0
        order_detail.save
      end
      cart_items.destroy_all
      redirect_to conplete_orders_path
    else
    end
  end

  def confirm
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @total_price = CartItem.calculate_total_price(@cart_items)
    @shipping_cost = 800
    @total_payment = @total_price + @shipping_cost
    @order = Order.new(order_params)
    case params[:order][:select_address]
    when "0"
      @order.attributes = current_customer.slice(:postal_code, :address)
      @order.name = current_customer.full_name
    when "1"
      destination_address = Address.find(params[:address_id])
      @order.attributes = destination_address.slice(:postal_code, :address, :name)
    when "2"
      if @order.postal_code.blank? || @order.address.blank? || @order.name.blank? || !(@order.postal_code).match?(/\A[0-9]+\z/)
        @addresses = Address.where(customer_id: current_customer.id)
        @checked = true
        render :new
      end

    end

    # @order = Order.new(order_params)
    # @cart_items = CartItem.where(customer_id: current_customer.id)
    # @total_price = CartItem.calculate_total_price(@cart_items)
    # @shipping_cost = 800
    # @total_payment = @total_price + @shipping_cost
    # case params[:select_address]
    #   when "1"
    #     @order.attributes = current_customer.slice(:postal_code, :address)
    #     @order.name = current_customer.full_name
    #   when "2"
    #     destination = Address.find(params[:address_id])
    #     @order.attributes = destination.slice(:postal_code, :address, :name)
    #   when "3"
    #     if !(@order.postal_code).match?(/\A[0-9]+\z/) || @order.invalid?
    #       @checked = :checked
    #       render :new
    #     end
    # else
    #   # render :new
    # end

  end

  def conplete
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end

end
