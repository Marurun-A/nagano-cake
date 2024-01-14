class OrderDetail < ApplicationRecord
 belongs_to :item
 belongs_to :order


 def subtotal
    item.with_tax_price * quantity
 end
end
