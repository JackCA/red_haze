module RedHaze
  class Track
    extend Helpers
    include Helpers::Resource

    attr_reader :id

    def initialize(arg)
      @id = arg
    end

    def favoriters
      User.get_from_endpoint(url + '/favoriters')
    end

    def comments
      Comment.get_from_endpoint(url + '/comments')
    end

  end
end
