class SearchController < ApplicationController
  include Swagger::Blocks
  before_action :authenticate_user!

  swagger_path '/search/{search_term}' do
    operation :get do
      key :description, 'Search for Movies in OMDB API'
      parameter do
        key :name, 'search_term'
        key :description, 'The Term to search for in OMDB API'
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
        key :description, "Array of searchresults (Movie Scheme) and Owns Array with ID's of all Movies the current User allready owns"
        schema do
          key :'$ref', :Movie
        end
      end
    end

  end
  def search
    owns = []
    search_term = params[:search_term]
    movies = OmdbApi.search(search_term) # liste von suchergebnissen
    unless movies.blank?
      movies.each do |m|
        owns << m.id if current_user.movies.include? m
      end
    end
    render json: {movies: movies, owns: owns}, status: 200
  end
end
