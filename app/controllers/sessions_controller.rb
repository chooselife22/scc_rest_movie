class SessionsController < ApplicationController
  include Swagger::Blocks

  #skip_before_filter :verify_authenticity_token, only: :auth_twitter
  #
  swagger_path '/sign_in' do
    operation :post do
      key :description, 'Login via email and password'
      parameter do
        key :name, 'user'
        key :description, 'JSON Object with keys "email" and "password"'
        key :in, :body
        key :required, true
        key :type, :string
        key :default, '{"user": {"email": "test@test.com", "password": "test"}}'
      end
      response 200 do
        key :description, 'Response with valid Authorization Token'
      end
      response 401 do
        key :description, 'Response if Credentials are invalid'
      end
    end
  end
  swagger_path '/sign_out' do
    operation :post do
      key :description, 'Logut'
      parameter do
        key :name, 'token'
        key :description, 'Your current Authorization Token'
        key :in, :body
        key :required, true
        key :type, :string
      end
      response 200 do
        key :description, 'Response for successfull logout'
      end
      response 404 do
        key :description, 'Response for failed logout'
      end
    end
  end

  swagger_path '/auth/google_oauth2' do
    operation :get do
      key :description, 'Intitial Request for OAuth2 flow with Google+'
      response 200 do
        key :description, 'Response with One Time Token from google if your credentials are correct'
      end
      response 404 do
        key :description, 'Reponse if your Crendentials are wrong'
      end
    end
  end

  def create
    identity = Identity.where(email: params[:user][:email]).first_or_create do |i|
      i.password = params[:user][:password]
      i.password_confirmation = params[:user][:password]
    end
    if identity && identity.authenticate(params[:user][:password])
      if identity.user.nil? 
        user = User.where(email: params[:user][:email]).first_or_create do |u|
          u.identities.push identity
        end
      else
        user = identity.user
      end
      token = user.auth_token
      json = handle_token(token, user)
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
    identity = Identity.from_google_oauth2(user_google_data)
    if identity.user.nil? 
      user = User.where(email: user_google_data["info"]["email"]).first_or_create do |u|
        u.name = user_google_data["info"]["name"]
        u.identities.push identity
      end
    else
      user = identity.user
    end
    token = user.auth_token
    json = handle_token(token, user)
    render json: json, status: 200
  end
  def oauth_failure
    @error = request.env['omniauth.error']
    render json: { message: "bist du dumm?" }, status: 401
  end

  def handle_token(token, user)
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
    json
  end
end
