module RedHaze
  module Helpers

    module Resource

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

      def sync
        hash_to_attributes Request.get(url)
        self
      end

      def url
        "/#{self.class.name.downcase.split('::')[-1]}s/#{id}"
      end

    end

  end
end
