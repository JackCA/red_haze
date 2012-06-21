module RedHaze
  module Helpers
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
  end
end
