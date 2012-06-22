module RedHaze
  class Group
    extend Helpers
    include Helpers::Resource

    attr_reader :id

    def initialize(arg)
      @id = arg
    end

    def members
      get_from_endpoint("/members")
    end

    def moderators
      get_from_endpoint("/moderators")
    end

    def contributors
      get_from_endpoint("/contributors")
    end

    def contributors
      get_from_endpoint("/contributors")
    end

    def users
      get_from_endpoint("/users")
    end


  end
end
