module RedHaze
  class Track
    include Helpers::Resource

    def favoriters
      get_endpoint('/favoriters')
    end

    def comments
      get_endpoint('/comments')
    end

    def shared_to
      get_endpoint('/shared_to/users')
    end

  end
end
