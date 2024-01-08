class Admin::CustomersController < ApplicationController

  def index
    @customer = Customer.all
  end

  def show
    @customers = Customer.find(params[:id])
  end

  def edit
      @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
      if @customer.update(customer_params)
        flash[:notice] = "You have updated user successfully."
        redirect_to public_customer_path(@customer.id)
      else
        render :edit
      end
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :postal_code, :address, :telephone_number, :customer_email)
  end

end
