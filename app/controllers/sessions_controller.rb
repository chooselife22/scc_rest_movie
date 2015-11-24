class SessionsController < ApplicationController
  def create
    user = User.find_by_email(params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      at = AuthToken.create
      render json: {
        message: 'you are now logged in',
        token: at.token,
      }, status: 200
    else
      render json: {
        message: 'invalid credentials, please try again'
      }, status: 401
    end
  end

  def destroy
    if session[:user_id] && token = AuthToken.find_by_token(params[:token])
      session[:user_id] = nil
      token.delete
      render json: {
        message: 'you are now logged out',
      }, status: 200
    else
      render json: {
        message: 'there are problems with your session or auth_token. i dont know'
      }, status: 404
    end
  end

  def index
    if current_user
      redirect_to '/movies'
    else
      redirect_to new_session_path
    end
  end

  def new
  end
end
