# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :customer_state, only: [:create]

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def after_sign_in_path_for(resource)
    public_root_path
  end

  def after_sign_out_path_for(resource)
    public_session_path
  end

  private
    def customer_state
      customer = Customer.find_by(email: params[:customer][:email])
      return if customer.nil?
      return unless customer.valid_password?(params[:customer][:password])

      if customer.is_active?
      flash[:alert] = "無効なアカウントです。"
      redirect_to new_customer_session_path
      end
    end
  end