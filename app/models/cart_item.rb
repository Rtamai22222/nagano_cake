class CartItem < ApplicationRecord
  belongs_to :customer
  # belongs_to :customer, foreign_key: 'id'
  belongs_to :item
  # belongs_to :item, foreign_key: 'id'

  # def get_image(width,height)
  #   unless image.attached?
  #     file_path = Rails.root.join('app/assets/images/default-image.jpg')
  #     profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  #   end
  #   image.variant(resize_to_limit: [width, height]).processed
  # end
end
