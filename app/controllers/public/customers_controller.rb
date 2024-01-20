class Public::CustomersController < ApplicationController

  def show
    @customers = Customer.find(params[:id])
  end

  def unsubscribe
    @customer = current_customer

  end

  def withdraw
    @customer = current_customer
    @customer.update(is_active: false)
    sign_out


      redirect_to public_root_path
  end

  def edit
    customer = Customer.find(params[:id])
    unless customer.id == current_customer.id
      redirect_to current_customer
    end

      @customer = Customer.find(params[:id])
  end

  def update

    customer = Customer.find(params[:id])
    unless customer.id == current_customer.id
      redirect_to public_customer_path
    end

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
    params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :postal_code, :address, :telephone_number, :email)
  end
end
