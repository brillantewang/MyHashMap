class Node
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
    # next_node = @next
    # prev_node = @prev
    # next_node.prev = prev_node
    # prev_node.next = next_node

    @next.prev, @prev.next = @prev, @next
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
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
    current_node = get_node_by_key(key)
    current_node.val
  end

  def include?(key)
    current_node = get_node_by_key(key)
    return false if current_node == @tail
    true
  end

  def append(key, val)
    new_node = Node.new(key, val)
    last_node = last

    @tail.prev = new_node
    last_node.next = new_node
    new_node.next = @tail
    new_node.prev = last_node

    new_node
  end

  def update(key, val)
    current_node = get_node_by_key(key)
    return if current_node == @tail
    current_node.val = val
  end

  def remove(key)
    current_node = get_node_by_key(key)
    return nil if current_node == @tail
    current_node.remove
  end

  def each(&prc)
    current_node = @head.next
    until current_node == @tail
      prc.call(current_node)
      current_node = current_node.next
    end
  end

  private
  def get_node_by_key(key)
    current_node = @head
    until current_node == @tail || current_node.key == key
      current_node = current_node.next
    end
    current_node
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
