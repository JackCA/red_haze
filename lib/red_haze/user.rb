require 'red_haze/helpers'

module RedHaze
  class User
    include RedHaze::Helpers

    attr_reader :id

    def initialize(arg)
      if arg.is_a? Fixnum
        @id = arg
      else
        hash_to_attributes arg
      end
    end

    def sync
      hash_to_attributes Request.execute(:get, url)
      self
    end

    def followings(user_id=nil)
      if user_id.nil?
        self.class.users_from_response Request.execute(:get, url + '/followings')
      else
        response = Request.execute(:get, url + "/followings/#{user_id}")
      end
    end

    def followers
      self.class.users_from_response Request.execute(:get, url + '/followers')
    end

    def comments
      Comment.comments_from_response Request.execute(:get, url + '/comments')
    end

    def favorites
      Track.tracks_from_response Request.execute(:get, url + '/favorites')
    end

    def self.users_from_response(response)
      response.collect { |r| new(r) }
    end

    private

    def url
      "/users/#{id}"
    end
  end

end
