class Api::V1::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token

  before_action :configure_permitted_parameters, only: [:create]

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation])
  end

  def create
    build_resource(sign_up_params)
    resource.save
    yield resource if block_given?
    respond_with resource
  end

  private

  def respond_with(resource, _opts = {})
    if resource.errors.any?
      register_failed(resource.errors.full_messages)
    else
      register_success(resource)
    end
  end

  def register_success(resource)
    render json: { message: 'Signed up.', resource: resource }
  end

  def register_failed(error_message)
    render json: { message: 'Signed up failure', errors: error_message }
  end

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
