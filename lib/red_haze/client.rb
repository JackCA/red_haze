module RedHaze
  class Client
    attr_reader :client_id

    def initialize(options={})
      @client_id = options[:client_id]
    end

  end
end
