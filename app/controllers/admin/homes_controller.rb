class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @orders = Order.all
    @order_details = OrderDetail.all
    @item_id = @order_details.first.item_id
    @order_id = @order_details.first.order_id
    @customer_id = @orders.first.customer_id
  end

end
