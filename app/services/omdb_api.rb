class OmdbApi
  include HTTParty

  OMDB_BASE_URL = 'http://www.omdbapi.com'

  def self.search(term)
    movies = []
    url = OMDB_BASE_URL + '/?s=' + term
    response = HTTParty.get(url)
    if response && response["Search"]
      search_results = response["Search"]
      search_results.each do |m|
        create_movie_if_not_exists!(m)
      end
      search_results.each do |sr|
        movie = Movie.find_by_imdb_id(sr["imdbID"])
        movies.push movie if movie
      end
      movies.each do |m|
        m.owns = current_user.movies.include? m
      end
      movies
    else
      movies
    end
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
end

