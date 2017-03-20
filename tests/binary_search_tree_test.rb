gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/binary_search_tree'
require 'pry'

class BinarySearchTreeTest < Minitest::Test
  def test_it_exists
    tree = BinarySearchTree.new
  end

  def test_can_make_root_node
    tree = BinarySearchTree.new
    expected = {"Bill & Ted's Excellent Adventure" => 61}
    assert_equal 0, tree.insert(61, "Bill & Ted's Excellent Adventure")
    assert_equal expected, tree.root.data
  end

  def test_it_can_add_second_node
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    assert_equal 1, tree.insert(16, "Johnny English")
    assert_nil tree.root.right
    assert_equal tree.root.left.data, {"Johnny English" => 16}
  end

  def test_it_can_add_third_node
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    assert_equal 1, tree.insert(92, "Sharknado 3")
    assert_equal tree.root.right.data, {"Sharknado 3" => 92}
  end

  def test_it_can_add_fourth_node
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    assert_equal 2, tree.insert(50, "Hannibal Buress: Animal Furnace") 
    assert_equal tree.root.left.right.data, {"Hannibal Buress: Animal Furnace" => 50}
    assert_nil tree.root.left.left
  end

  def test_include?
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "Hannibal Buress: Animal Furnace") 
    tree.insert(55, "This movie doesn't matter")
    assert tree.include?(16)
    assert tree.include?(50)
    refute tree.include?(72)
    assert tree.include?(55)
  end

  def test_depth_of
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "Hannibal Buress: Animal Furnace") 
    assert_equal 1, tree.depth_of(92)
    assert_equal 2, tree.depth_of(50)
    assert_nil tree.depth_of(10)
  end

  def test_max
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "Hannibal Buress: Animal Furnace") 
    expected = {"Sharknado 3" => 92 }
    assert_equal expected, tree.max
  end

  def test_min
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "Hannibal Buress: Animal Furnace") 
    expected = {"Johnny English"=>16}
    assert_equal expected, tree.min
  end

  def test_collect_data
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "Hannibal Buress: Animal Furnace")
    expected = [{"Bill & Ted's Excellent Adventure"=>61},
                {"Johnny English"=>16},
                {"Hannibal Buress: Animal Furnace"=>50},
                {"Sharknado 3"=>92}]
    assert_equal expected, tree.collect_data
    
  end

  def test_sort
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "Hannibal Buress: Animal Furnace")
    expected = [{"Johnny English"=>16},
                {"Hannibal Buress: Animal Furnace"=>50},
                {"Bill & Ted's Excellent Adventure"=>61},
                {"Sharknado 3"=>92}] 
    assert_equal expected, tree.sort
  end

  def test_load
    tree = BinarySearchTree.new
    actual = tree.load("../movies.txt")
    # binding.pry
    assert_equal 99, actual
  end
  def test_tree_health
    tree = BinarySearchTree.new
    tree.insert(98, "Animals United")
    tree.insert(58, "Armageddon")
    tree.insert(36, "Bill & Ted's Bogus Journey")
    tree.insert(93, "Bill & Ted's Excellent Adventure")
    tree.insert(86, "Charlie's Angels")
    tree.insert(38, "Charlie's Country")
    tree.insert(69, "Collateral Damage")
    expected = [[98, 7, 100]]
    assert expected, tree.health(0)
    expected = [[58, 6, 85]]
    assert expected, tree.health(1)
    expected = [[36, 2, 28], [93, 3, 42]]
    assert expected, tree.health(2)
  end

  def test_count
    tree = BinarySearchTree.new
    tree.insert(98, "Animals United")
    tree.insert(58, "Armageddon")
    tree.insert(36, "Bill & Ted's Bogus Journey")
    tree.insert(93, "Bill & Ted's Excellent Adventure")
    tree.insert(86, "Charlie's Angels")
    tree.insert(38, "Charlie's Country")
    tree.insert(69, "Collateral Damage")
    assert_equal 7, tree.count
  end
  
  def test_health_per_node
    tree = BinarySearchTree.new
    tree.insert(98, "Animals United")
    tree.insert(58, "Armageddon")
    tree.insert(36, "Bill & Ted's Bogus Journey")
    tree.insert(93, "Bill & Ted's Excellent Adventure")
    tree.insert(86, "Charlie's Angels")
    tree.insert(38, "Charlie's Country")
    tree.insert(69, "Collateral Damage")
    expected = [98, 7, 100]
    assert_equal expected, tree.health_at_node
    expected = [58, 6, 85]
    assert_equal expected, tree.health_at_node(tree.root.left)
  end
end