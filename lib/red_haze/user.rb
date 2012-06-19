require 'red_haze/helpers'

module RedHaze
  class User
    include RedHaze::Helpers

    attr_reader :id

    def initialize(id)
      @id = id
    end

    def get_profile
      response = Request.execute(:get, url)
      hash_to_attributes response
      self
    end

    def url
      "/users/#{id}"
    end
  end

end
