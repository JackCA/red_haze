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
      raise ArgumentError unless [RedHaze::Me, Fixnum].include?(arg.class)
    end

    def activities(args = {})
      filter = args.delete(:filter) || :all
      raise "Bad Activities filter: #{filter}" unless FILTERS.include?(filter)

      filter = filter.to_s.sub('_','/')

      get_from_endpoint("/activities/#{filter}", args)
    end

  end
end
