require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable

  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket = bucket(key)
    @store[bucket].include?(key)
  end

  def set(key, val)
    resize! if count == num_buckets

    bucket = bucket(key)
    if @store[bucket].include?(key)
      @store[bucket].update(key, val)
    else
      @count += 1
      @store[bucket].append(key, val)
    end
  end

  def get(key)
    bucket = bucket(key)
    @store[bucket].get(key)
  end

  def delete(key)
    bucket = bucket(key)
    @count -= 1 if @store[bucket].remove(key)
  end

  def each(&prc)
    @store.each do |list|
      list.each { |node| prc.call([node.key, node.val]) }
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    nodes = []
    each { |k, v| nodes << [k, v] }
    @store = Array.new(@count * 2) { LinkedList.new }
    @count = 0
    nodes.each do |k, v|
      set(k, v)
    end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    key.hash % num_buckets
  end
end
