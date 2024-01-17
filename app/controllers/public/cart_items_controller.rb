class Public::CartItemsController < ApplicationController

  def create
    @cart_item = CartItem.find_by(item_id: params[:cart_item][:item_id])
    if @cart_item
      @cart_item.amount += cart_item_params[:amount].to_i
    else
      @cart_item = CartItem.new(cart_item_params)
    end
    @cart_item.customer_id = current_customer.id
    @cart_item.save
    redirect_to public_cart_items_path
  end

  def index
    @cart_items = CartItem.all
    @items = Item.all
    @cart_item = @items.all
    @total = 0
  end

  def update
      @cart_item = CartItem.find(params[:id])
    unless @cart_item.customer_id == current_customer.id
      redirect_to public_items_path
      return
    end

    if @cart_item.update(amount: params[:amount].to_i)
      redirect_to public_cart_items_path
    else
      redirect_to public_items_path
    end
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to public_cart_items_path
  end

  def destroy_all
    CartItem.destroy_all
    redirect_to public_items_path
  end

  private

    def cart_item_params
      params.require(:cart_item).permit(:amount, :item_id, :customer_id)
    end

end
