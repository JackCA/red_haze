module RedHaze
  class Group
    include Helpers::Resource

    attr_reader :id

    def members
      get_endpoint("/members")
    end

    def moderators
      get_endpoint("/moderators")
    end

    def contributors
      get_endpoint("/contributors")
    end

    def contributors
      get_endpoint("/contributors")
    end

    def users
      get_endpoint("/users")
    end

  end
end
