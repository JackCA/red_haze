require "red_haze/version"
require "red_haze/client"
require "red_haze/request"
require "red_haze/response"
require "red_haze/user"
require "red_haze/track"
require "red_haze/comment"

module RedHaze
  class << self
    attr_accessor :client
    def configure(options = {})
      @client = Client.new(options)
      Request.setup(@client.client_id)
      self
    end
  end
end
