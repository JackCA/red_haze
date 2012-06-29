require 'red_haze/user'

module RedHaze
  class Me < User
    def initialize
      sync
    end
  end
end
