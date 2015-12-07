class SearchController < ApplicationController
  before_action :authenticate_user!

  def search
    search_term = params[:search_term]
    movies = OmdbApi.search(search_term) #json liste von suchergebnissen
    render json: {movies: movies}, status: 200
  end
end
