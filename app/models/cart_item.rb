class CartItem < ApplicationRecord
  has_one_attached :image
  belongs_to :item

  def with_tax_price
    (item.price * 1.1).floor
  end

  def subtotal
    with_tax_price * amount
  end

end
