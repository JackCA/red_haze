module RedHaze
  class Comment
    extend Helpers
    include Helpers::Resource

    attr_reader :id

    def initialize(arg)
      @id = arg
    end

  end
end
