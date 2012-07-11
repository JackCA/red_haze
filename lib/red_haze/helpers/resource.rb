module RedHaze
  module Helpers

    module Resource
      def self.included(base)
        base.extend(ClassMethods)
      end

      attr_reader :id

      def initialize(arg)
        case arg
          when Fixnum then @id = arg
          when Hash then initialize_from_hash(arg)
          else raise "Not a valid Resource initialize arg: #{arg.inspect}"
        end
      end

      def sync
        initialize_from_hash Request.get(url)
        self
      end

      def get_from_endpoint(endpoint, params={})
        self.class.import_from_response Request.get(url + endpoint, query: params)
      end

      def url
        class_name = self.class.name.downcase.split('::')[-1]
        class_name == 'me' ? '/me' : "/#{class_name}s/#{id}"
      end

      private

        def initialize_from_hash(arg)
          arg.each_pair do |key, value|
            case key
              when 'created_at'
                value = DateTime.parse(value)
              when 'user', 'creator', 'track'
                value = User.new(value)
            end
            instance_variable_set "@#{key}", value
            self.class.class_eval { attr_reader key }
          end
        end

    module ClassMethods

      def instance_from_hash(arg)
        case
          when arg['kind']
            class_name = arg.delete('kind').capitalize
            eval(class_name).new(arg)
          when arg['type']
            Activity.new arg
          when arg['collection']
            Collection.new arg
          when arg.values.first['kind']
            instance_from_hash arg.values.first
          else
            raise arg.inspect
        end
      end


      def import_from_response(response)
        if response.is_a? Array
          response.collect { |i| instance_from_hash(i) }
        elsif response.is_a? Hash
          instance_from_hash response
        end
      end

    end

  end
  end
end
