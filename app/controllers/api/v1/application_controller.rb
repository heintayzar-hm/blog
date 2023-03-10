class Api::V1::ApplicationController < ActionController::API
  respond_to :json

  before_action :authenticate_user!

  def authenticate_user!
    unless user_signed_in?
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def user_signed_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find_by(jti: payload['sub'])
  end

  def payload
    if token
      @payload ||= { 'sub' => token }
    else
      {}
    end
  end


  def token
    request.headers['Authorization']&.split&.last
  end

end
