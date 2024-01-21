class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @orders = Order.all
    @order_details = OrderDetail.all
    @item_id = @order_details
    @order_id = @order_details
    @customer_id = @orders
  end

end
