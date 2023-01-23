class CartItem < ApplicationRecord
   belongs_to :customer, :item
   belongs_to :item
end
