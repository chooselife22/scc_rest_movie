class SearchController < ApplicationController
  before_action :authenticate_user!

  def search
    search_term = params[:search_term]
    search_results = OmdbApi.search(search_term) #json liste von suchergebnissen
    json = {
      search_results: search_results
    }
    render json: json, status: 200
  end

end
