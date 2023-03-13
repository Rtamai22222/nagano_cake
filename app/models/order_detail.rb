class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order

  enum making_status: { not_producible: 0, waiting_production: 1, in_production: 2, production_completed: 3 }

  def self.total_amount
    self.sum(&:amount)
  end

  def order_detail_subtotal
    price_with_tax*amount
  end

end
