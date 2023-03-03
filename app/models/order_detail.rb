class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order

  def self.total_amount
    self.sum(&:amount)
  end

end
