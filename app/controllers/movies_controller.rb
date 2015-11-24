class MoviesController < ApplicationController
  before_action :authenticate_user!

  def index
    @movies = current_user.movies
    render json: {
      movies: @movies
    }
  end
end
