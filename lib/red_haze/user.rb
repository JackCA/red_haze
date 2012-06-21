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
        self.class.import_from_response Request.get(url + '/followings')
      else
        response = Request.get(url + "/followings/#{user_id}")
      end
    end

    def followers
      self.class.import_from_response Request.get(url + '/followers')
    end

    def comments
      Comment.import_from_response Request.get(url + '/comments')
    end

    def favorites
      Track.import_from_response Request.get(url + '/favorites')
    end

    def groups
      Group.import_from_response Request.get(url + '/groups')
    end

  end

end
