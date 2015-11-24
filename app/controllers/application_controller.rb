class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  def current_user
    if session[:user_id]
      User.find(session[:user_id])
    else
      nil
    end
  end

  def authenticate_user!
    if params[:token]
      at = AuthToken.find_by_token(params[:token])
      if  at && at.valid_token?
        at.extend_auth_token
      else
        redirect_to '/sessions/new'
      end
    else
      render json: {
        message: "you are not allowed to view movies. check your auth_token"
      }, status: 403
    end
  end
end
