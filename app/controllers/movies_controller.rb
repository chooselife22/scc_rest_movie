class MoviesController < ApplicationController
  before_action :authenticate_user!

  def index
    binding.pry
    @movies = current_user.movies
    render json: {
      movies: @movies
    }
  end
end
