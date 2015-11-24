class SearchController < ApplicationController
  before_action :authenticate_user!

  def search
    #searchterm = params[:search][:term]
    #string muss jetzt zu omdbapi.com/?s=searchterm
    search_results = OmdbApi.search("indiana") #json liste von suchergebnissen
    json = {
      search_results: search_results
    }
    status = 200
    render json: json, status: status
  end
end
