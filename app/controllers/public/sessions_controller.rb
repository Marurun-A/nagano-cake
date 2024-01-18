# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]
  before_action :customer_state, only: [:create]

  protected

    def configure_sign_in_params
      devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
    end

    def after_sign_in_path_for(resource)
      public_customer_path(@customer.id)
    end

    def after_sign_out_path_for(resource)
      customer_session_path
    end


    def customer_state
      customer = Customer.find_by(email: params[:customer][:email])
      return if customer.nil?
      return unless customer.valid_password?(params[:customer][:password])

      if customer.is_active == false
      flash[:alert] = "無効なアカウントです。"
      redirect_to new_customer_session_path
      end
    end
  end