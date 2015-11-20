class SessionsController < ApplicationController
  def create
    user = User.find_by_email(params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      at = AuthToken.create
      render json: {
        status: 200,
        token: at.token
      }
    else
      render json: {
        status: 401
      }
    end
  end

  def destroy
    if session[:user_id] && token = AuthToken.find_by_token(params[:token])
      session[:user_id] = nil
      token.delete
      render json: {
        status: 200
      }
    else
      render json: {
        status: 'alles kapputt'
      }
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
