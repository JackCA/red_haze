module RedHaze
  class Comment
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

  end
end
