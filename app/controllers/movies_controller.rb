class MoviesController < ApplicationController
  include Swagger::Blocks

  before_action :authenticate_user!

  swagger_path '/movies' do
    operation :get do
      key :description, 'Returns all Movies of the Current User'
      parameter do
        key :name, 'Authorization'
        key :description, 'Your current Authorization Token'
        key :in, :header
        key :required, true
        key :type, :string
      end
      response 200 do
        key :description, 'All Movies of the current user'
        schema do
          key :'$ref', :Movie
        end
      end
      response 403 do
        key :description,  'Response if token is not valid or missing with "response_status": "token_expired"/"token_missing"'
      end
    end
  end

  def index
    @movies = current_user.movies
    render json: {
      movies: @movies
    }, status: 200
  end

  swagger_path '/movies/{id}' do
    operation :get do
      key :description, 'Returns the Movie of the current user identified by the given ID'
      parameter do
        key :name, 'id'
        key :description, 'ID of the Movie'
        key :in, :path
        key :required, true
        key :type, :string
      end
      parameter do
        key :name, 'Authorization'
        key :description, 'Your current Authorization Token'
        key :in, :header
        key :required, true
        key :type, :string
      end
      response 200 do
        key :description, 'The requested Movie'
        schema do
          key :'$ref', :Movie
        end
      end
    end
  end
  def show
    render json: {movie: movie}, status: 200
  end

  swagger_path '/movies' do
    operation :post do
      key :description, "Adds a Movie to the current Users Movies identified by it's ID"
      parameter do
        key :name, 'Movie ID'
        key :description, 'ID of the Movie'
        key :in, :body
        key :required, true
        key :type, :string
      end
      parameter do
        key :name, 'Authorization'
        key :description, 'Your current Authorization Token'
        key :in, :header
        key :required, true
        key :type, :string
      end
      response 200 do
        key :description, 'The added Movie'
        schema do
          key :'$ref', :Movie
        end
      end
    end
  end
  def create
    current_user.movies.push movie
    render json: {movie: movie}, status: 201
  end

  swagger_path '/movies/{id}' do
    operation :delete do
      key :description, "deletes a Movie from the current Users Movies identified by it's ID"
      parameter do
        key :name, 'id'
        key :description, 'ID of the movie you want to remove from the current users movies'
        key :in, :path
        key :required, true
        key :type, :integer
        key :default, '<id>'
      end
      parameter do
        key :name, 'Authorization'
        key :description, 'Your current Authorization Token'
        key :in, :header
        key :required, true
        key :type, :string
      end
      response 200 do
        key :description, 'no content'
        schema do
          key :'$ref', :Movie
        end
      end
    end
  end
  def delete
    current_user.movies.delete(movie)
    render json: {message: 'movies succesfully deleted from your list'}, status: 200
  end

  private

  def movie
    Movie.find(params[:id])
  end
end
