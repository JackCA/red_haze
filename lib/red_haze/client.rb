require "httparty"

module RedHaze
  class Client
    include HTTParty
    attr_accessor :client_id, :client_secret, :redirect_uri, :access_token, :expires_in, :refresh_token

    REQUIRED_KEYS = [:client_id,:client_secret]
    TOKEN_ENDPOINT = "https://api.soundcloud.com/oauth2/token"
    CONNECT_ENDPOINT = "https://soundcloud.com/connect"

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
      params = "client_id=#{@client_id}&redirect_uri=#{@redirect_uri}&response_type=code"
      URI.encode "#{CONNECT_ENDPOINT}?#{params}"
    end

    def get_token_from_code(code)
      body =  { client_id:      @client_id,
                client_secret:  @client_secret,
                redirect_uri:   @redirect_uri,
                code:           code,
                grant_type:     'authorization_code' }

      response = self.class.post TOKEN_ENDPOINT, body: body,
                  headers: {'Content-Type' => 'application/x-www-form-urlencoded'}

      raise response.inspect unless response.code == 200
      puts response.inspect
      @access_token = response.access_token
      @expires_in = response.expires_in
      @refresh_token = response.refresh_token
      self
    end

  end
end
