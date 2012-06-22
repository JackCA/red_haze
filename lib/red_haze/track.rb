module RedHaze
  class Track
    include Helpers::Resource

    attr_reader :id

    def favoriters
      get_from_endpoint('/favoriters')
    end

    def comments
      get_from_endpoint('/comments')
    end

  end
end
