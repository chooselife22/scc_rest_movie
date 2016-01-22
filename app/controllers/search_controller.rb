class SearchController < ApplicationController
  before_action :authenticate_user!

  def search
    search_term = params[:search_term]
    movies = OmdbApi.search(search_term) #json liste von suchergebnissen
    unless movies.blank?
      movies.each do |m|
        m.owns = current_user.movies.include? m
      end
    end
    render json: {movies: movies}, status: 200
  end
end
