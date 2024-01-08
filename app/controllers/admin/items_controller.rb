class Admin::ItemsController < ApplicationController

  def new
    @item = Item.new
  end

  def create

    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "You have created item successfully."
      redirect_to admin_items_path(@item)
    else @items = Item.all
      render :index
    end
  end

  def index
    @items = Item.all
    @item = Item.new
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit

    # item = .find(params[:id])
    # unless book.user_id == current_user.id
    # redirect_to books_path
    # end

    @item = Item.find(params[:id])
  end

  def update

    # item = Item.find(params[:id])
    # unless book.user_id == current_user.id
    #   redirect_to books_path
    # end

    @item = Item.find(params[:id])
      if @item.update(item_params)
        flash[:notice] = "You have updated item successfully."
        redirect_to admin_items_path(@item)
      else
        render :edit
      end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to admin_items_path
  end



  private

  def item_params
    params.require(:item).permit(:image, :name, :introduction, :price)
  end

end
