require 'red_haze/helpers'

module RedHaze
  class Comment
    include RedHaze::Helpers

    attr_reader :id

    def initialize(arg)
      @id = arg
    end

    def sync
      hash_to_attributes Request.execute(:get, url)
      self
    end

    private

    def url
      "/comments/#{id}"
    end

  end
end
