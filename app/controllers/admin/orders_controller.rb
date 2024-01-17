class Admin::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @customer = @order.customer
    @customer_column_value = @customer.column_last_name
  end

end
