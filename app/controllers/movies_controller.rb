class MoviesController < ApplicationController
  include Swagger::Blocks

  before_action :authenticate_user!

  swagger_path '/movies' do
    operation :get do
      key :description, 'Returns all Movies of the Current User'
      response 200 do
        key :description, 'Movies Response'
        schema do
          key :'$ref', :Movie
        end
      end
    end
  end
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
    render json: {movie: movie}, status: 201
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
