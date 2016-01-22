class ApiDocuController < ApplicationController
  def index
    render file: 'public/apidocs/index.html'
  end
end
