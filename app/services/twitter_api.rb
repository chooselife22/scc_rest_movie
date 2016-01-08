module TwitterApi
  class Connector
    def initialize(token, secret, callback)
      @callback = callback
      @consumer = OAuth::Consumer.new(
        token,
        secret,
        :request_token_path => '/oauth/request_token',
        :authorize_path     => '/oauth/authorize',
        :access_token_path  => '/oauth/access_token',
        :site               => 'https://api.twitter.com'
      )
    end

    def get_request_token
      @request_token = @consumer.get_request_token(:oauth_callback => @callback)
    end

    def authorize_url
      @request_token.authorize_url(:oauth_callback => @callback)
    end

    def auth_token(params)
      @token = @request_token.get_access_token params
    end

    # Use this method, when user come back again, to generate a new access token auth token and secret
    def from_auth_token_and_secret(token, secret)
      @token = OAuth::AccessToken.from_hash(@consumer,
                                            :oauth_token => token,
                                            :oauth_token_secret => secret)
    end

    def token
      @token || raise( "Please use either #auth_token or #from_auth_token_and_secret to set the AuthToken first" )
    end
  end
end
