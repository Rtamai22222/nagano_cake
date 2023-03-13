class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def price_with_tax
    (price*1.1).floor
  end

end
