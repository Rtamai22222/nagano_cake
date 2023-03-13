class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item

  def self.calculate_total_price(cart_items)
    total_price = 0
    cart_items.each do |itemlist|
      total_price += (itemlist.item.price * 1.1).floor * itemlist.amount
    end
    return total_price
  end

  def subtotal
    item.with_tax_price*amount
  end

end
