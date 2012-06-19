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

    def get_profile
      response = Request.execute(:get, url)
      hash_to_attributes response
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

    def url
      "/users/#{id}"
    end

    private

    def self.users_from_response(response)
      response.collect { |r| new(r) }
    end
  end

end
