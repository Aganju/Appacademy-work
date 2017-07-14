class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    number = 0
    hash = Hash.new { |h,k| h[k] = [] }
    self.each_with_index do |el, idx|
      number += el.hash * idx.hash
    end
    return number
  end
end

class String
  def hash
    self.chars.map(&:ord).hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.keys.map(&:to_s).sort.hash * self.values.sort.hash
  end
end
