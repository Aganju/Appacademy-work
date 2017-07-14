require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    square = nil
    if @map.include?(key)  
      square = @map[key].val
      update_link!(@map[key])
    else
      square = calc!(key)
      @map[key] = @store.append(key, square)
      eject! if @store.count > @max
    end
    square
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    @prc.call(key)
  end

  def update_link!(link)
    link.remove
    @map[link.key] = @store.append(link.key, link.val)
  end

  def eject!
    last_key = @store.first.key
    @map.delete(last_key)
    @store.first.remove
  end
end
