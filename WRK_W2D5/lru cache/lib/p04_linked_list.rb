class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    self.prev.next = self.next
    self.next.prev = self.prev
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Link.new
    @tail= Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    link = find { |link| link.key == key }
    link.val if link
  end

  def include?(key)
    any? { |link| link.key == key }
  end

  def append(key, val)
    new_link = Link.new(key, val)
    last.next = new_link
    new_link.prev= last
    new_link.next = @tail
    @tail.prev = new_link
  end

  def update(key, val)
    link = find { |link| link.key == key }
    link.val = val if link
  end

  def remove(key)
    link = find { |link| link.key == key }
    if link
      link.remove
    end
  end

  def each(&prc)
    curr_link = @head
    until curr_link.next == @tail
      curr_link = curr_link.next
      prc.call(curr_link)
    end
    self
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
