class Item < ApplicationRecord
  # belongs_to :genre, foreign_key: 'id'
  belongs_to :genre
  has_many :cart_items
  has_many :order_details

  has_one_attached :image

  validates :genre_id, presence: true
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  # validates :is_active, presence :true ＝＞boolen型にpresenceは使えない
  validates :is_active, inclusion: [true, false]
  # validates :image, presence: true
  
  def get_image(width,height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/default-image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
  
end
