module RedHaze
  class Track
    include Helpers::Resource

    def favoriters
      get_from_endpoint('/favoriters')
    end

    def comments
      get_from_endpoint('/comments')
    end

    def shared_to
      get_from_endpoint('/shared_to/users')
    end

    def owner
      sync if user_id.nil?
      User.new(user_id)
    end

  end
end
