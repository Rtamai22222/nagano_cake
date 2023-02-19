class Public::CustomersController < ApplicationController
  def show
    @cart_all = CartItem.all
  end

  def edit
  end
end
