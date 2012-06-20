module RedHaze
  class Comment
    include RedHaze::Helpers

    attr_reader :id

    def initialize(arg)
      @id = arg
    end

    def sync
      hash_to_attributes Request.get(url)
      self
    end

    def self.comments_from_response(response)
      response.collect { |r| new(r) }
    end

    private

    def url
      "/comments/#{id}"
    end

  end
end
