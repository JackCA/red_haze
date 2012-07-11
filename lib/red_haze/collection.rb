module RedHaze
  class Collection
    include Helpers::Resource
    attr_reader :items, :next_href, :future_href
    def initialize(arg)
      @items = arg['collection'].collect { |r| Activity.new(r) }
      @next_href = arg['next_href']
      @future_href = arg['future_href']
    end

    def next
      self.class.new Request.get(@next_href)
    end

  end
end
