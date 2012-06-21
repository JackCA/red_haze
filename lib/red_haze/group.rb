module RedHaze
  class Group
    include Helpers

    attr_reader :id

    def initialize(arg)
      @id = arg
    end

    def sync
      hash_to_attributes Request.get(url)
      self
    end

    private

    def url
      "/groups/#{id}"
    end
  end
end
