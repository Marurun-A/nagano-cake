class Public::OrdersController < ApplicationController

  def new
    @orders = Order.new
    @addresses = current_customer.addresses
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    # byebug
    @order.save

    current_customer.cart_items.each do |cart_item|
      @order_details = OrderDetail.new
      @order_details.order_id =  @order.id
      @order_details.item_id = cart_item.item_id
      @order_details.quantity = cart_item.amount
      @order_details.purchase_price = (cart_item.item.price*1.08).floor
      @order_details.save
      end

      current_customer.cart_items.destroy_all
      redirect_to  public_orders_complete_path
  end

  def confirm
    @order = Order.new(order_params)

      if params[:order][:address_option] == "0"
        @order.postal_code = current_customer.postal_code
        @order.address = current_customer.address
        @order.name = current_customer.full_name
      elsif params[:order][:address_option] == "1"
        # ship = Address.find(params[:order][:customer_id])
        # @order.postal_code = postal_code
        # @order.address = address
        # @order.delivery_name = name
      elsif params[:order][:address_option] = "2"
      #   @order.postal_code = params[:order][:postal_code]
      #   @order.address = params[:order][:address]
      #   @order.delivery_name = params[:order][:delivery_name]
        else
            render 'new'
        end

      @cart_items = current_customer.cart_items
      @order.customer_id = current_customer.id
  end

  def complete
  end

  def index
    @orders = Order.where(customer_id: current_customer.id)
    @order_details = OrderDetail.find_by(order_id: @orders.first.id)
    @item_id = @order_details.item_id
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end


  private

  def order_params
    params.require(:order).permit(:postage, :payment_method, :delivery_name, :address, :postal_code ,:customer_id,:total_payment,:billing_amount)
  end
end
