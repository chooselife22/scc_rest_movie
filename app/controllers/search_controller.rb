class SearchController < ApplicationController
  before_action :authenticate_user!

  def search
    search_term = params[:search_term]
    search_results = OmdbApi.search(search_term) #json liste von suchergebnissen
    search_results.each do |m|
      create_movie_if_not_exists!(m)
    end
    json = {
      search_results: search_results
    }
    render json: json, status: 200
  end

  private

  def create_movie_if_not_exists!(m)
    movie = Movie.where(imdb_id: m["imdbID"]).first_or_initialize
    if movie.new_record?
      movie.imdb_id = m["imdbID"]
      movie.remote_poster_url = m["Poster"]
      movie.title = m["Title"]
      movie.release = m["Year"]
      movie.save
    end
  end

end
