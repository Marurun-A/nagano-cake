class Order < ApplicationRecord
  enum payment_method: { credit_card: 0, transfer: 1 }
 has_many :items, through: :cart_items
 has_many :order_details
 belongs_to :customer


  def addresses
  '〒' + postal_code + ' ' + address + ' ' + delivery_name
  end

  def name=(value)
    @name = value
  end

  def name
    @name
  end



end
