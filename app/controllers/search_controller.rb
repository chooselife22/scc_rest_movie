class SearchController < ApplicationController
  before_action :authenticate_user!

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
