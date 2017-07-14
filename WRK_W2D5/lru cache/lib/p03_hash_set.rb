require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if @count == @store.length
      resize!
      insert(key)
    else
      remove(key)
      @store[self[key]] << key
      @count += 1
    end
  end

  def include?(key)
    @store[self[key]].include?(key)
  end

  def remove(key)
    @count -= 1 if @store[self[key]].delete(key)

  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    num.hash % @store.length
  end

  def num_buckets
    @store.length
  end

  def resize!
    temp = @store.dup
    @store = Array.new(@count * 2) { Array.new }

    temp.each do |bucket|
      bucket.each { |val| @store[self[val]] << val }
    end
  end
end
