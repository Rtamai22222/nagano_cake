class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_details

  has_one_attached :image

  validates :genre_id, presence: true
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  # validates :is_active, presence :true ＝＞boolen型にpresenceは使えない
  validates :is_active, inclusion: [true, false]
  # validates :image, presence: true

  scope :active, -> { where(is_active: true) }

  # def get_image(width,height)
  #   unless image.attached?
  #     file_path = Rails.root.join('app/assets/images/default-image.jpg')
  #     image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  #   end
  #   image.variant(resize_to_limit: [width, height]).processed
  # end

  def get_image(width,height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/default-image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_fill: [width, height]).processed
  end

  def with_tax_price
    (price*1.1).floor
  end

end
