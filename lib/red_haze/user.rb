module RedHaze
  class User
    extend Helpers
    include Helpers::Resource

    attr_reader :id

    def initialize(arg)
      if arg.is_a? Fixnum
        @id = arg
      else
        hash_to_attributes arg
      end
    end

    def followings(user_id=nil)
      if user_id.nil?
        self.class.get_from_endpoint(url + '/followings')
      else
        response = Request.get(url + "/followings/#{user_id}")
      end
    end

    def followers
      self.class.get_from_endpoint(url + '/followers')
    end

    def comments
      Comment.get_from_endpoint(url + '/comments')
    end

    def favorites
      Track.get_from_endpoint(url + '/favorites')
    end

    def groups
      Group.get_from_endpoint(url + '/groups')
    end

  end

end
