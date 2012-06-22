module RedHaze
  class Track
    extend Helpers
    include Helpers::Resource

    attr_reader :id

    def initialize(arg)
      if arg.is_a? Hash
        hash_to_attributes arg
      else
        @id = arg
      end
    end

    def favoriters
      get_from_endpoint('/favoriters')
    end

    def comments
      get_from_endpoint('/comments')
    end

  end
end
