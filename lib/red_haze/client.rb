module RedHaze
  class Client
    attr_reader :client_id

    def initialize(options={})
      if options.keys.sort != [:client_id,:client_secret]
        raise "missing client_id or client_secret"
      end
      @client_id = options[:client_id]
      @client_secret = options[:client_secret]
    end

  end
end
