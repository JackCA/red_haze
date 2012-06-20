require 'httparty'

module RedHaze
  class Request
    include HTTParty
    debug_output
    base_uri 'http://api.soundcloud.com'
    headers 'Accept' => 'application/json'

    def self.setup(client_id)
      default_params client_id: client_id
    end

  end
end
