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
      User.users_from_response Request.execute(:get, url + '/favoriters')
    end

    def comments
      Comment.comments_from_response Request.execute(:get, url + '/comments')
    end

    def self.tracks_from_response(response)
      response.collect { |r| new(r) }
    end

    private

    def url
      "/tracks/#{id}"
    end

  end
end
