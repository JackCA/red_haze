require "red_haze/version"
require 'red_haze/helpers'
require "red_haze/client"
require "red_haze/request"
require "red_haze/playlist"
require "red_haze/me"
require "red_haze/user"
require "red_haze/track"
require "red_haze/comment"
require "red_haze/group"

module RedHaze
  class << self
    attr_accessor :client

    def configure(options = {})
      @client = Client.new(options)
      Request.setup(@client.client_id, @client.access_token)
      self
    end

    def configure_from_file(path)
      configure YAML.load_file(path)
    end
  end
end
