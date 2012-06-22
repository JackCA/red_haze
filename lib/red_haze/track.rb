module RedHaze
  class Track
    extend Helpers
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
