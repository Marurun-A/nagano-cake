class CartItem < ApplicationRecord
  has_one_attached :image
  belongs_to :item
  belongs_to :customer, foreign_key: :customer_id

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  def with_tax_price
    (item.price * 1.1).floor
  end

  def subtotal
    with_tax_price * amount
  end

end
