class MaxIntSet
  def initialize(max)
    @max = max
    @store = Array.new(max) { false }
  end

  def insert(num)
    raise "Out of bounds" unless is_valid?(num)
    @store[num] = true
  end

  def remove(num)
    raise "Out of bounds" unless is_valid?(num)
    raise "Number not in set" if @store[num] == false
    @store[num] = false
  end

  def include?(num)
    raise "Out of bounds" unless is_valid?(num)
    @store[num] == true
  end

  private

  def is_valid?(num)
    num <= @max && num >= 0
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    bucket_number = num % num_buckets
    unless self[bucket_number].include?(num)
      @store[bucket_number] << num
    end
  end

  def remove(num)
    bucket_number = num % num_buckets
    if self[bucket_number].include?(num)
      self[bucket_number].delete(num)
    end
  end

  def include?(num)
    bucket_number = num % num_buckets
    self[bucket_number].include?(num)
  end

  private

  def [](num)
    @store[num]
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
    if @count == num_buckets
      resize!
    end
    bucket_number = num % num_buckets
    unless self[bucket_number].include?(num)
      @store[bucket_number] << num
      @count += 1
    end
  end

  def remove(num)
    bucket_number = num % num_buckets
    if self[bucket_number].include?(num)
      self[bucket_number].delete(num)
    end
  end

  def include?(num)
    bucket_number = num % num_buckets
    self[bucket_number].include?(num)
  end

  private

  def [](num)
    @store[num]
  end

  def num_buckets
    @store.length
  end

  def resize!
    flatten_store = @store.flatten
    @store = Array.new(@count * 2) { Array.new }
    @count = 0
    flatten_store.each do |num|
      insert(num)
    end
  end
end
