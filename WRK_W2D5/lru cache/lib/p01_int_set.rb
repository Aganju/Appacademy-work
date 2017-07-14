class MaxIntSet
  def initialize(max)
    @max = max
    @store = Array.new(max) { false }
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num] == true
  end

  private

  def is_valid?(num)
    num <= @max && num > 0
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    remove(num)
    @store[self[num]] << num
  end

  def remove(num)
    @store[self[num]].delete(num)
  end

  def include?(num)
    @store[self[num]].include? num
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    num % 20
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if @count == @store.length
      resize!
      insert(num)
    else
      remove(num)
      @store[self[num]] << num
      @count += 1
    end

  end

  def remove(num)
    @count -= 1 if @store[self[num]].delete(num)
  end

  def include?(num)
    @store[self[num]].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    num % @store.length
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
