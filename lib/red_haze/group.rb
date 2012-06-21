module RedHaze
  class Group
    extend Helpers
    include Helpers::Resource

    attr_reader :id

    def initialize(arg)
      @id = arg
    end

    def members
      User.get_from_endpoint(url + "/members")
    end

    def moderators
      User.get_from_endpoint(url + "/moderators")
    end

    def contributors
      User.get_from_endpoint(url + "/contributors")
    end

  end
end
