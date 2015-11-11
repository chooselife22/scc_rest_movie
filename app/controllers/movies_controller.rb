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
    unless AuthToken.find_by_token(params[:token]).valid_token?
      redirect_to '/sessions/new'
    end
  end
end
