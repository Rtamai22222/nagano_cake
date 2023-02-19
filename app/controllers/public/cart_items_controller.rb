class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @total_price = 0
    @cart_items.each do |itemlist|
      @total_price += (itemlist.item.price*1.1).floor*(itemlist.amount)
    end
    # @items = Item.all
  end

  def create
    @cart = CartItem.new(cart_params)
    if customer_signed_in?
      @cart.save
      redirect_to cart_items_path
    else
      redirect_to new_customer_registration_path
    end
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    cart_items = CartItem.where(customer_id: current_customer.id)
    cart_items.destroy_all
    redirect_to cart_items_path
  end

private

  def cart_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end

end