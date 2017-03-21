require_relative "node"
require 'pry'

class BinarySearchTree
  attr_accessor :root

  def initialize
    @root = nil
  end
  
  def lookup(direction, current)
    lookup = { :left => current.left, :right => current.right}
    lookup[direction]
  end
  def method_lookup()
    
  end
  def insert(rating, title)
    if root.nil?
      @root = Node.new({title => rating}) ; 0
    else
      insert_next_node({title => rating})
    end
  end

  def insert_next_node(value, node=root, depth=1)
    if insert_with_open_nodes(value, node, depth)
      return depth
    else
      node, depth = level_down(node, value.values[0], depth)
      insert_next_node(value, node, depth)
    end
  end


  def insert_with_open_nodes(value, node, depth)
    if node.data.values[0] > value.values[0] && node.right.nil?
      node.right = Node.new(value)
      return depth
    elsif node.data.values[0] < value.values[0] &&    
    node.left.nil?
      node.left = Node.new(value)
      return depth
    end
    false
  end


  def include?(rating, node=root)
    return false if node.nil?
    return true if node.data.values[0] == rating
    if !is_greater?(node, rating)
      include?(rating, node.left) 
    else
      include?(rating, node.right)
    end
  end
  
  def level_down(node, value, depth)
    depth += 1
    if is_greater?(node, value)
      [node.right, depth]
    else
      [node.left, depth]
    end
  end

  def is_greater?(node, value)
    node.data.values[0] > value
  end

  def depth_of(value, node=root, depth=0)
    return nil if node.nil?
    return depth if node.data.values[0] == value
    node, depth = level_down(node, value, depth)
    depth_of(value, node, depth)
  end
  

  def max
    max = root
    until !lookup(:left, max)
      max = lookup(:left, max)
    end
    max.data
  end

  def min
    min = root
    until !lookup(:right, min)
      min = lookup(:right, min)
    end
    min.data
  end

  def sort(current=root, sorted=[])
    check_nodes(:right, current, sorted)
    sorted << current.data
    check_nodes(:left, current, sorted)
    sorted
  end

  def check_nodes(direction, current, sorted)
    if lookup(direction, current)
      sort(lookup(direction, current), sorted)
    end
  end

  def load(file)
    successfully_added = 0
    create_movie_array(file).each do |line|
      insert(line[0].to_i, line[1])
      successfully_added += 1
    end
    successfully_added
  end

  def create_movie_array(file)
    movies = File.readlines(file)
    movies.map! do |movie|
      movie.chomp.split(", ")
    end
  end

  def health(depth, node=root, collection = [])
    return collection if node.nil?
    collection << health_at_node(node) if depth_of(node.data.values[0]) == depth
    health(depth, node.right, collection)
    health(depth, node.left, collection)
  end

  def health_at_node(current_node=root)
    node_health = []   
    node_health << current_node.data.values[0]
    node_health << count(current_node)
    node_health << ((count(current_node).to_f/count.to_f) * 100).floor
  end

  def count(node=root, array = [])
    if node.nil?
      return
    end
    array << 1
    count(node.right, array)
    count(node.left, array)
    array.inject(&:+)
  end
end