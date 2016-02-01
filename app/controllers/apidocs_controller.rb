class ApidocsController < ApplicationController
  include Swagger::Blocks

  swagger_root do
    key :swagger, '2.0'
    info do
      key :version, '1.0.0'
      key :title, 'Swagger Movies'
    end
    info do
      contact do
        key :name, 'andy.schreiter@mailbox.tu-dresden.de, oliver.winke@gmail.com, pdienst@gmx.net'
      end
    end
    #key :host, 'http://localhost:3000'
    key :basePath, '/'
    key :consumes, ['application/json']
    key :produces, ['application/json']
    #security_definition :google_oauth2 do
    #  key :type, :oauth2
    #  key :authorizationUrl, 'https://accounts.google.com/o/oauth2/v2/auth'
    #  key :tokenUrl, "https://accounts.google.com/o/oauth2/token"
    #  key :flow, :accessCode
    #end
  end

  SWAGGERED_CLASSES = [
    SessionsController,
    SearchController,
    MoviesController,
    Movie,
    self
  ].freeze

  def index
    render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
  end

  def docu
  end
end
