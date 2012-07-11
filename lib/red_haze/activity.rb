module RedHaze
  class Activity
    include Helpers::Resource

    attr_reader :origin, :type, :created_at

    def initialize(arg)
      @type = arg['type']
      @created_at = DateTime.parse arg['created_at']
      @origin = self.class.instance_from_hash arg['origin']
    end

  end
end
