class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  validates :customer_id, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :name, presence: true
  validates :shipping_cost, presence: true
  validates :total_payment, presence: true
  validates :payment_method, presence: true
  validates :status, presence: true

  enum payment_method: { credit_card: 0, transfer: 1 }
  # enum status_method: { payment_pending: 0, payment_confirmed: 1, making: 2, preparing_shipment: 3, shipped: 4 }
  enum status: { payment_pending: 0, payment_confirmed: 1, making: 2, preparing_shipment: 3, shipped: 4 }

  def address_display
    '〒' + postal_code + ' ' + address + ' ' + name
  end

end
