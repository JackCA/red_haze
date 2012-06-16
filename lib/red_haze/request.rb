require 'httparty'

module RedHaze
  class Request
    include HTTParty
    debug_output

    attr_accessor :type, :path, :query

    base_uri 'http://api.soundcloud.com'
    headers 'Accept' => 'application/json'

    def initialize(type, path, query={})
      @type = type
      @path = path
      @query = query
      @query[:client_id] = RedHaze.client.client_id
    end

    def execute
      self.class.send(type, path, query: query)
    end

    def self.execute(*args)
      new(*args).execute
    end

  end
end
