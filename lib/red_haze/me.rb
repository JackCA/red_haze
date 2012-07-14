require 'red_haze/user'

module RedHaze
  class Me < User
    FILTERS = [:all, :tracks_affiliated, :tracks_exclusive, :own]

    def initialize
      unless RedHaze.client.access_token
        raise "You cannot access this object without a client access_token"
      end
      sync
    end

    def follow!(arg)
      put_endpoint "/followings/#{follow_id(arg)}"
    end

    def unfollow!(arg)
      delete_endpoint "/followings/#{follow_id(arg)}"
    end

    # if we do follow the user, we are redirected to a 404 page
    # this will rescue on the first redirect and thus return true
    def follows?(arg)
      Request.get "/me/followings/#{follow_id(arg)}", no_follow: true
      false
    rescue HTTParty::RedirectionTooDeep
      true
    end

    def activities(args = {})
      filter = args.delete(:filter) || :all
      raise "Bad Activities filter: #{filter}" unless FILTERS.include?(filter)

      filter = filter.to_s.sub('_','/')

      get_endpoint("/activities/#{filter}", query: args)
    end

    private
      def follow_id(arg)
        raise ArgumentError unless [RedHaze::User, Fixnum].include?(arg.class)
        arg.is_a?(Fixnum) ? arg : arg.id
      end

  end
end
