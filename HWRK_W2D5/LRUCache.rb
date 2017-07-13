class LRUCache
    def initialize(size)
      @max_size = size
      @cache = []
    end

    def count
      @cache.length
    end

    def add(el)
      @cache.delete(el)
      @cache.shift if count == @max_size
      @cache << el
    end

    def show
      print @cache
    end

    private
    # helper methods go here!

end
