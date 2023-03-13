class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items
    @total_price = 0
  end

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_amount_params)
    redirect_to cart_items_path
  end

  def create
    if customer_signed_in?
      new_cart_item = CartItem.new(cart_item_params)
      cart_products = current_customer.cart_items
      if new_cart_item.amount.present?
        if cart_products.find_by(item_id: new_cart_item.item_id)
          existing_item = cart_products.find_by(item_id: new_cart_item.item_id)
          existing_item.amount += new_cart_item.amount
          existing_item.update(amount: existing_item.amount)
          redirect_to cart_items_path
        else
          if new_cart_item.save
            redirect_to cart_items_path
          else
            # render item_path(params[:item_id])
          end
        end
      else
        redirect_to item_path(new_cart_item.item_id)
        # @genres = Genre.all
        # @item = Item.find(new_cart_item.item_id)
        # render template: "public/items/show"
      end
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

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end

  def cart_item_amount_params
    params.require(:cart_item).permit(:amount)
  end

end