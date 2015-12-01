class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  #skip_before_action :verify_authenticity_token

  def current_user
    if headers[:authentication]
      token = AuthToken.find_by_token(params[:token])
      user = token.user
      user if user
      #TODO user nicht vorhanden
    end
  end

  def authenticate_user!
    if params[:token]
      at = AuthToken.find_by_token(params[:token])
      if  at && at.valid_token?
        at.extend_auth_token
      else
        render json: {
          message: "your token is out of date, please login and try again"
        }, status: 403
      end
    else
      render json: {
        message: "you are not allowed to view movies. check your auth_token"
      }, status: 403
    end
  end
end
