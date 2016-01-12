class SessionsController < ApplicationController
  #skip_before_filter :verify_authenticity_token, only: :auth_twitter

  def create
    user = User.find_by_email(params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      token = user.auth_token
      if token && token.valid_token?
        token.extend_auth_token
        json = {
          message: 'you are now logged in',
          token: token.token,
        } 
      elsif token && !token.valid_token?
        token.delete
        at = AuthToken.create
        user.auth_token = at
        user.save!
        json = {
          message: 'you are now logged in',
          token: at.token,
        } 
      elsif !token
        at = AuthToken.create
        user.auth_token = at
        user.save!
        json = {
          message: 'you are now logged in',
          token: at.token,
        } 
      end
      render json: json, status: 200
    else
      render json: {
        message: 'invalid credentials, please try again'
      }, status: 401
    end
  end

  def destroy
    if token = AuthToken.find_by_token(params[:token])
      token.delete
      render json: {
        message: 'you are now logged out',
      }, status: 200
    else
      #irgendwie komisch hier
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

  def create_from_google_oauth2
    user_google_data = request.env['omniauth.auth']
    user = User.from_google_oauth2(user_google_data)

    binding.pry

    token = user.auth_token
    if token && token.valid_token?
      token.extend_auth_token
      json = {
        message: 'you are now logged in',
        token: token.token,
      } 
    elsif token && !token.valid_token?
      token.delete
      at = AuthToken.create
      user.auth_token = at
      user.save!
      json = {
        message: 'you are now logged in',
        token: at.token,
      } 
    elsif !token
      at = AuthToken.create
      user.auth_token = at
      user.save!
      json = {
        message: 'you are now logged in',
        token: at.token,
      } 
    end
    render json: json, status: 200
  end
  def oauth_failure
    @error = request.env['omniauth.error']
    render json: { message: "bist du dumm?" }, status: 401
  end
end
