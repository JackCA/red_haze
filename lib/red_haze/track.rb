require 'red_haze/helpers'

module RedHaze
  class Track
    include RedHaze::Helpers

    attr_reader :id

    def initialize(arg)
      @id = arg
    end

    def sync
      hash_to_attributes Request.execute(:get, url)
      self
    end

    def favoriters
      Track.users_from_response Request.execute(:get, url + '/favoriters')
    end

    private

    def url
      "/tracks/#{id}"
    end

  end
end
