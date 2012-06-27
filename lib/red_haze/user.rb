module RedHaze
  class User
    include Helpers::Resource

    attr_reader :id
    
    def followings(user_id=nil)
      if user_id.nil?
        get_from_endpoint('/followings')
      else
        response = get("/followings/#{user_id}")
      end
    end

    def followers
      get_from_endpoint('/followers')
    end

    def comments
      get_from_endpoint('/comments')
    end

    def favorites
      get_from_endpoint('/favorites')
    end

    def groups
      get_from_endpoint('/groups')
    end

    def playlists
      get_from_endpoint('/playlists')
    end

  end

end
