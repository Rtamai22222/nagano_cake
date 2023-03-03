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
  enum status_method: { waiting: 0, confirm: 1, making: 2 }

  def address_display
    '〒' + postal_code + ' ' + address + ' ' + name
  end

end
