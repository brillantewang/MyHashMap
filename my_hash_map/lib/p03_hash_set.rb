require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(el)
    if @count == num_buckets
      resize!
    end
    bucket_number = el.hash % num_buckets
    unless self[bucket_number].include?(el)
      @store[bucket_number] << el
      @count += 1
    end
  end

  def remove(el)
    bucket_number = el.hash % num_buckets
    if self[bucket_number].include?(el)
      self[bucket_number].delete(el)
    end
  end

  def include?(el)
    bucket_number = el.hash % num_buckets
    self[bucket_number].include?(el)
  end

  private

  def [](el)
    @store[el]
  end

  def num_buckets
    @store.length
  end

  def resize!
    flatten_store = @store.flatten
    @store = Array.new(@count * 2) { Array.new }
    @count = 0
    flatten_store.each do |el|
      insert(el)
    end
  end
end
