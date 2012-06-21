module RedHaze
  class Track
    extend Helpers
    include Helpers::Resource

    attr_reader :id

    def initialize(arg)
      @id = arg
    end

    def favoriters
      User.import_from_response Request.get(url + '/favoriters')
    end

    def comments
      Comment.import_from_response Request.get(url + '/comments')
    end

  end
end
