module RedHaze
  module Helpers
    def hash_to_attributes(hash)
      hash.each_pair do |key, value|
        instance_variable_set "@#{key}", value
        self.class.class_eval { attr_reader key }
      end
    end
  end
end
