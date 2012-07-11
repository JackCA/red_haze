require "httparty"

module RedHaze
  class Client
    include HTTParty
    attr_accessor :client_id, :client_secret, :redirect_uri,
                  :access_token, :expires_in, :refresh_token

    TOKEN_ENDPOINT = "https://api.soundcloud.com/oauth2/token"
    CONNECT_ENDPOINT = "https://soundcloud.com/connect"

    def initialize(options={})
      options_check(options)
      update_from_response(options)
    end

    def authorize_url
      raise "Missing redirect_uri" unless redirect_uri
      params = "client_id=#{client_id}&redirect_uri=#{redirect_uri}&response_type=code"
      URI.encode "#{CONNECT_ENDPOINT}?#{params}"
    end

    def get_token_from_code(code)
      body =  { client_id:      client_id,
                client_secret:  client_secret,
                redirect_uri:   redirect_uri,
                code:           code,
                grant_type:     'authorization_code' }

      response = self.class.post TOKEN_ENDPOINT, body: body,
                  headers: {'Content-Type' => 'application/x-www-form-urlencoded'}

      raise response.inspect unless response.code == 200
      update_from_response(response)
      self
    end

    private

    def options_check(options)
      keys = options.keys
      unless (keys.include?(:client_id) && keys.include?(:client_secret)) ||
              keys.include?(:access_token)
        raise "missing client_id and client_secret, or access_token"
      end
    end

    def update_from_response(response)
      @client_id = response[:client_id]
      @client_secret = response[:client_secret]
      @redirect_uri = response[:redirect_uri]
      @access_token = response[:access_token]
      @expires_in = response[:expires_in]
      @refresh_token = response[:refresh_token]
    end

  end
end
