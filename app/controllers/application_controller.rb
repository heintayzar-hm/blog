class ApplicationController < ActionController::Base
  helper_method :current_user
  def current_user
    # first user
    User.first
  end
end
