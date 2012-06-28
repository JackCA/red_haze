require 'httparty'

module RedHaze
  class Request
    include HTTParty
    debug_output
    base_uri 'http://api.soundcloud.com'
    headers 'Accept' => 'application/json'

    def self.setup(client_id,access_token=nil)
      params = {client_id: client_id}
      params[:access_token] = access_token unless access_token.nil?
      default_params params
    end

  end
end
