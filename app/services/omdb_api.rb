require 'uri'
class OmdbApi
  include HTTParty

  OMDB_BASE_URL = 'http://www.omdbapi.com'

  def self.search(term)
    movies = []
    url = OMDB_BASE_URL + '/?s=' + URI.escape(term)
    response = HTTParty.get(url)
    if response && response["Search"]
      search_results = response["Search"]
      search_results.each do |m|
        create_movie_if_not_exists!(m)
      end
      search_results.each do |sr|
        movie = Movie.find_by_imdb_id(sr["imdbID"])
        update_with_further_attributes!(movie) if movie.genre.blank?
        movies.push movie if movie
      end
      movies
    else
      movies
    end
  end

  def self.imdb_id(id)
    m = {}
    url = OMDB_BASE_URL + '/?i=' + id
    response = HTTParty.get(url)
    if response && response["Response"]
      m = response
    end
    m
  end

  def self.create_movie_if_not_exists!(m)
    movie = Movie.where(imdb_id: m["imdbID"]).first_or_initialize
    if movie.new_record?
      movie.imdb_id = m["imdbID"]
      movie.remote_poster_url = m["Poster"]
      movie.title = m["Title"]
      movie.release = m["Year"]
      movie.save
    end
  end

  def self.update_with_further_attributes!(mov)
    m = imdb_id(mov["imdbID"])
    movie = Movie.where(imdb_id: m["imdbID"]).first_or_initialize
    movie.genre = m["Genre"]
    movie.imdb_rating = m["imdbRating"]
    movie.imdb_type = m["Type"]
    movie.save
  end
end

