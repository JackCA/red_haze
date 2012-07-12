module RedHaze
  class User
    include Helpers::Resource
    
    def followings(user_id=nil)
      if user_id.nil?
        get_endpoint('/followings')
      else
        response = get("/followings/#{user_id}")
      end
    end

    def followers
      get_endpoint('/followers')
    end

    def comments
      get_endpoint('/comments')
    end

    def favorites
      get_endpoint('/favorites')
    end

    def groups
      get_endpoint('/groups')
    end

    def playlists
      get_endpoint('/playlists')
    end

  end

end
