require_relative 'helpers/resource'

module RedHaze
  module Helpers

    def get_from_endpoint(url)
      import_from_response Request.get(url)
    end

    private 

    def import_from_response(response)
      response.collect { |r| new(r) }
    end
  end
end
