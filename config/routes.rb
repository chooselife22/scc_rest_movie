Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  get '/movies', to: 'movies#index'
  get '/movies/:id', to: 'movies#show'
  delete '/movies',to: 'movies#delete'
  post '/movies', to: 'movies#create'

  get '/search/:search_term', to: 'search#search'
  get '/search/title/:title', to: 'search#title'
  get '/search/id/:id', to: 'search#id'

  resources :sessions, only: [:new, :index]

  post '/sign_in', to: 'sessions#create'
  post '/sign_out', to: 'sessions#destroy'

  post '/auth/:provider/callback', to: 'sessions#create_from_google_oauth2'   

  # You can have the root of your site routed with "root"
  root 'sessions#index'
end
