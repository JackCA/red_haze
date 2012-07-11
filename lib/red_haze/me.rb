require 'red_haze/user'

module RedHaze
  class Me < User
    def initialize
      unless RedHaze.client.access_token
        raise "You cannot access this object without a client access_token"
      end
      sync
    end

    def follow!(arg)
      raise ArgumentError unless [RedHaze::Me, Fixnum].include?(arg.class)
    end

    def activities(args = {})
      get_from_endpoint('/activities', args)
    end

  end
end
