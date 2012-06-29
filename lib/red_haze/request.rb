require 'httparty'

module RedHaze
  class Request
    include HTTParty
    debug_output
    headers 'Accept' => 'application/json'

    def self.setup(client_id,access_token=nil)
      params = {}
      if access_token
        base_uri 'https://api.soundcloud.com'
        params[:oauth_token] = access_token
      else
        base_uri 'http://api.soundcloud.com'
        params[:client_id] = client_id
      end
      default_params params
    end

  end
end
