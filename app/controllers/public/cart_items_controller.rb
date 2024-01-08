class Public::CartItemsController < ApplicationController

  def create

    @cart_item = CartItem.new(cart_item_params)
    if @cart_item.save
      redirect_to public_cart_items_path
    else @cart_items = CartItem.all
      render :index
    end
  end

  def index
    @cart_items = CartItem.all
    @total = 0
    
    @cart_items.destroy_all
    
  end

  def update

    cart_item = CartItem.find(params[:id])
    unless cart_item.customer_id == current_customer.id
      redirect_to public_items_path
    end

    @cart_item = CartItem.find(params[:id])
      if @cart_item.update(cart_item_params)
        redirect_to public_cart_item_path(@cart_item.id)
      else
        render :index
      end
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to public_item_path
  end

  private

    def cart_item_params
      params.require(:cart_item).permit(:amount, :item_id, :customer_id)
    end

end
