module RedHaze
  class User
    extend Helpers
    include Helpers::Resource

    attr_reader :id

    def initialize(arg)
      if arg.is_a? Fixnum
        @id = arg
      else
        hash_to_attributes arg
      end
    end

    def followings(user_id=nil)
      if user_id.nil?
        get_from_endpoint('/followings')
      else
        response = get("/followings/#{user_id}")
      end
    end

    def followers
      get_from_endpoint('/followers')
    end

    def comments
      get_from_endpoint('/comments')
    end

    def favorites
      get_from_endpoint('/favorites')
    end

    def groups
      get_from_endpoint('/groups')
    end

  end

end
