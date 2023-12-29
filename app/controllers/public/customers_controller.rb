class Public::CustomersController < ApplicationController
  
  def show
    Customer.find_by(name: 'sign_out')
    @cutomer = Customer.find(params[:id])
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
    params.require(:customer).permit(:name, :name_kana,)
  end
end
