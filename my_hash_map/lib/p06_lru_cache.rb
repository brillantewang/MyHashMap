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
    if @map.include?(key)
      node = @map.get(key)
      update_node!(node)
    else
      eject! if count == @max
      calc!(key)
      node = @map.get(key)
    end
    node.val
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    node = @store.append(key, @prc.call(key))
    @map.set(key, node)
  end

  def update_node!(node)
    @store.remove(node.key)
    node = @store.append(node.key, node.val)
    @map.set(node.key, node)
  end

  def eject!
    node = @store.first
    @store.remove(node.key)
    @map.delete(node.key)
  end
end
