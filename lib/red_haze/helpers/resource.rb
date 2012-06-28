module RedHaze
  module Helpers

    module Resource
      attr_reader :id

      def initialize(arg)
        case arg
          when Fixnum then @id = arg
          when Hash then hash_to_attributes(arg)
          else raise
        end
      end

      def sync
        hash_to_attributes Request.get(url)
        self
      end

      def get_from_endpoint(endpoint)
        import_from_response Request.get(url + endpoint)
      end

      private 

      def hash_to_attributes(hash)
        hash.each_pair do |key, value|
          case key
            when 'created_at'
              value = DateTime.parse(value)
            when 'user', 'creator'
              value = User.new(value)
          end
          instance_variable_set "@#{key}", value
          self.class.class_eval { attr_reader key }
        end
      end

      def url
        "/#{self.class.name.downcase.split('::')[-1]}s/#{id}"
      end

      def import_from_response(response)
        raise "The response 404ed: #{response.inspect} \n\n Request: #{response.request.inspect}" if response.code == 404
        class_name = response.first.delete('kind').capitalize
        response.collect { |r| eval(class_name).new(r) }
      end

    end

  end
end
