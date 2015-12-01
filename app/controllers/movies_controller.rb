class MoviesController < ApplicationController
  before_action :authenticate_user!
  before_action only: [:show]

  def index
    @movies = current_user.movies
    render json: {
      movies: @movies
    }, status: 200
  end

  def show
    render json: {movie: movie}, status: 200
  end

  def create
    current_user.movies.push movie
  end

  def delete
    current_user.movies.delete(movie)
    render json: {message: 'movies succesfully deleted from your list'}, status: 204
  end

  private

  def movie
    Movie.find(params[:id])
  end
end
