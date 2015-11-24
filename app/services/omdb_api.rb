class OmdbApi
  include HTTParty

  OMDB_BASE_URL = 'http://www.omdbapi.com'

  def self.search(term)
    url = OMDB_BASE_URL + '/?s=' + term
    response = HTTParty.get(url)
    if response && response["Search"]
      response["Search"]
    else
      []
    end
  end
end

