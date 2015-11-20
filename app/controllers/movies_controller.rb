class MoviesController < ApplicationController
  before_action :authenticate_user!

  def index
    @movies = current_user.movies
    render json: {
      movies: @movies
    }
  end

  private

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
        status: 403,
        message: "Forbidden... HAHAHAHA"
      }
    end
  end
end
