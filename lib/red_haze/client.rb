require "httparty"

module RedHaze
  class Client
    include HTTParty
    attr_reader :client_id, :client_secret, :redirect_uri, :access_token, :expires_in, :refresh_token

    REQUIRED_KEYS = [:client_id,:client_secret]

    def initialize(options={})
      keys = options.keys
      unless (keys & REQUIRED_KEYS ).sort == REQUIRED_KEYS
        raise "missing client_id or client_secret"
      end
      @client_id = options[:client_id]
      @client_secret = options[:client_secret]
      @redirect_uri = options[:redirect_uri]
      @access_token = options[:access_token]
      @expires_in = options[:expires_in]
      @refresh_token = options[:refresh_token]
    end

    def authorize_url
      params = "client_id=#{@client_id}&client_secret=#{@client_secret}&redirect_uri=#{@redirect_uri}&respone_type=token_and_code"
      URI.encode("https://soundcloud.com/connent?" + params)
    end

    def get_token_from_code(code)
      response = self.class.post "https://api.soundcloud.com/oauth2/token", body: {client_id: @client_id, client_secret: @client_secret, redirect_uri: @redirect_uri, code: code, grant_type: 'authorization_code'}
      raise unless response.code == 400
      @access_token = response.access_token
      @expires_in = response.expires_in
      @refresh_token = response.refresh_token
      self
    end

  end
end
