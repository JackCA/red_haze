require_relative 'helpers/resource'

module RedHaze
  module Helpers
    def import_from_response(response)
      response.collect { |r| new(r) }
    end
  end
end
