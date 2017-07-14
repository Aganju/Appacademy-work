class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  include Enumerable
  attr_reader :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    @store[i]
  rescue
    nil
  end

  def []=(i, val)
    @store[i] = val
  rescue
    nil
  end

  def capacity
    @store.length
  end

  def include?(val)
  end

  def push(val)
    @store[@count] = val
    @count += 1
  rescue
    nil
  end

  def unshift(val)
    new_arr = StaticArray.new(@store.length + 1)
    new_arr[0] = val
    i = 1
    while i <= @count
      new_arr[i] = @store[i - 1]
      i += 1
    end
    @store = new_arr
    @count += 1
    self
  end

  def pop
    return nil if @count == 0
    popped = @store[count - 1]
    @store[count - 1] = nil
    @count -= 1
    popped
  end

  def shift
    temp = @store[0]
    i = 0
    @count -= 1
    while i < @count
      @store[i] = @store[i + 1]
      i += 1
    end
    @store[i] = nil
    temp
  end

  def first
    @store[0]
  end

  def last
    @store[@count - 1]
  end

  def each(&prc)
    i = 0
    while i < @count
      prc.call(@store[i])
      i += 1
    end
    self
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    # ...
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    # temp = @store.dup
    # @store = Array.new(@count * 2) { LinkedList.new }

  end
end
