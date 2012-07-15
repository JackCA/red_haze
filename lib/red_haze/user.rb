module RedHaze
  class User
    include Helpers::Resource
    
    def followings
      get_endpoint("/followings/#{user_id}")
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
