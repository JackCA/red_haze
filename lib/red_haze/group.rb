module RedHaze
  class Group
    include Helpers::Resource

    attr_reader :id

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
