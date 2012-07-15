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

    def activities(args = {})
      filter = args.delete(:filter) || :all
      raise "Bad Activities filter: #{filter}" unless FILTERS.include?(filter)

      filter = filter.to_s.sub('_','/')

      get_endpoint("/activities/#{filter}", query: args)
    end

    def follow!(arg)
      put_endpoint "/followings/#{item_id(arg)}"
    end

    def unfollow!(arg)
      delete_endpoint "/followings/#{item_id(arg)}"
    end

    def follows?(arg)
      existence_check "/me/followings", arg
    end

    def favorite!(arg)
      put_endpoint "/favorites/#{item_id(arg)}"
    end

    def unfavorite!(arg)
      delete_endpoint "/favorites/#{item_id(arg)}"
    end

    def favorite?(arg)
      existence_check "/me/favorites", arg
    end

    private

      def item_id(arg)
        unless [RedHaze::User, RedHaze::Track, Fixnum].include?(arg.class)
          raise ArgumentError 
        end
        arg.is_a?(Fixnum) ? arg : arg.id
      end

      # if the resource exists, we are redirected to a 404 page
      # this will rescue on the first redirect and thus return true
      def existence_check(path, arg)
        response = Request.get "#{path}/#{item_id(arg)}", no_follow: true
        response.code == 200
      rescue HTTParty::RedirectionTooDeep
        true
      end

  end
end
