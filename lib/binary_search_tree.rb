require_relative "node"
require 'pry'

class BinarySearchTree
  attr_accessor :root

  def initialize
    @root = nil
  end
  
  def insert(rating, title)
    if root.nil?
      @root = Node.new({title => rating})
      return 0
    else
      insert_next_node({title => rating})
    end
  end

  def insert_next_node(data, node=root, depth = 1 )
    level = depth
    if node.data.values[0] > data.values[0] && node.left.nil?
      node.left = Node.new(data)
      return depth
    elsif node.data.values[0] < data.values[0] && node.right.nil?
      node.right = Node.new(data)
      return depth
    elsif node.data.values[0] > data.values[0]
      level += 1
      insert_next_node(data, node.left, level)
    else
      level += 1
      insert_next_node(data, node.right, level)
    end
  end

  def include?(rating, node=root)
    return false if node.nil?
    return true if node.data.values[0] == rating

    if rating > node.data.values[0]
      include?(rating, node.right)
    elsif
      rating < node.data.values[0]
      include?(rating, node.left)
    end
  end

  def depth_of(value, node=root, depth=0)
    level = depth
    return nil if node.nil?
    return level if node.data.values[0] == value
    
    if node.data.values[0] > value
      level += 1
      depth_of(value, node.left, level)
    else
      level += 1
      depth_of(value, node.right, level)
    end    
  end

  def max
    max = root
    until max.right.nil?
      max = max.right
    end
    max.data
  end

  def min
    min = root
    until min.left.nil?
      min = min.left
    end
    min.data
  end

  def sort
    collect_data.sort_by{|title| title.values[0]}
  end

  def collect_data(node=root, collection = [])
    collected = collection
    return collected if node.nil?
    collection << node.data
    collect_data(node.left, collection)
    collect_data(node.right, collection)
  end

  def create_move_array(file)
    movies = File.readlines(file)
    movies.map! do |movie|
      movie.chomp.split(", ")
    end
  end
  def load(file)
    successfully_added = 0
    create_move_array(file).each do |line|
      insert(line[0].to_i, line[1])
      successfully_added += 1
    end
    p successfully_added
  end

  def health(depth, node=root, collection = [])
    collected = collection
    return collected if node.nil?
    collection << health_at_node(node) if depth_of(node.data.values[0]) == depth
    health(depth, node.left, collection)
    health(depth, node.right, collection)
  end

  def health_at_node(current_node=root)
    total = count    
    score = current_node.data.values[0]
    binding.pry
    percentage = ((count(current_node).to_f/count.to_f) * 100).floor
    child_nodes = count(current_node)
    node_health = [score, child_nodes, percentage]
    node_health
  end

  def count(node=root, array = [])
    if node.nil?
      return
    end
    array << 1
    count(node.left, array)
    count(node.right, array)
    array.inject(&:+)
  end
end