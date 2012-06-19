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
        response = Request.execute(:get, url + '/followings')
        response.collect { |r| self.class.new(r) }
      else
        response = Request.execute(:get, url + "/followings/#{user_id}")
      end
    end

    def followers
      response = Request.execute(:get, url + '/followers')
      response.collect { |r| self.class.new(r) }
    end

    def url
      "/users/#{id}"
    end
  end

end
