# Represents a binary tree
class BinaryTree
  attr_reader :root

  def initialize
    @root = Node.new
  end

  # Given an array of values (data), creates a binary tree
  def build_tree(data)
    @root.value = data[0] unless data.empty?
    data[1..-1].each do |value|
      new_node = Node.new(value)
      node = @root
      saved_node = nil
      until node == nil
        if value >= node.value
          saved_node = node
          node = node.right_child
        else
          saved_node = node
          node = node.left_child
        end
      end
      if value >= saved_node.value
        saved_node.right_child = new_node
        new_node.parent = saved_node
      else
        saved_node.left_child = new_node
        new_node.parent = saved_node
      end
    end
  end

  # Given a target value, returns the node at which it is located
  # or nil if not found using the breadth first search technique
  def breadth_first_search(value)
    queue = [@root]
    until queue.empty?
      node = queue.shift
      return node if node.value == value
      left = node.left_child
      right = node.right_child
      queue << left unless left.nil?
      queue << right unless right.nil?
    end
    nil
  end

  # Given a target value, returns the node at which it is located
  # or nil if not found using the depth first search (in-order) technique
  def depth_first_search(value)
    stack = [@root]
    until stack.empty?
      node = stack.pop
      return node if node.value == value
      left = node.left_child
      right = node.right_child
      stack << right unless right.nil?
      stack << left unless left.nil?
    end
    nil
  end

  # Given a target value, returns the node at which it is located
  # or nil if not found using the dfs (in-order) technique with recursion
  def dfs_rec(value, node=@root)
    return if node.nil?
    return node if node.value == value
    dfs_rec(value, node.left_child) || dfs_rec(value, node.right_child)
  end

end

# Represents a singular node in the tree
class Node
  attr_accessor :parent, :left_child, :right_child, :value

  def initialize(value=nil)
    @value = value
    @parent = nil
    @left_child = nil
    @right_child = nil
  end

end
