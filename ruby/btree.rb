# 1. Given a binary tree as an array, find its maximum depth. The maximum depth is the number of nodes along the
# longest path from the root node down to the farthest leaf node.

# Examples
# Given the binary tree [3, 9, 20, nil, nil, 15, 7],
#
#    3
#   / \
#  9  20
#    /  \
#   15   7
#
# it should return depth = 3.
#
# Given the binary tree [3, 9, 20, nil, nil, 15, 7, nil, nil, nil, nil, 4, 5],
#
#    3
#   / \
#  9  20
#    /  \
#   15   7
#  /  \
# 4   5
# it should return depth = 4.

def max_depth(btree)
  def traverse(btree, i = 0, depth = 0)
    if i < btree.length
      root = btree[i]

      unless root.nil?
        depth += 1

        left = btree[left_i = 2*i + 1]
        right = btree[right_i = 2*i + 2]

        left_depth = left.nil? ? depth : traverse(btree, left_i, depth)
        right_depth = right.nil? ? depth : traverse(btree, right_i, depth)

        depth = right_depth > left_depth ? right_depth : left_depth
      end
    end
    depth
  end

  traverse(btree)
end

btree1 = [3, 9, 20, nil, nil, 15, 7]
max_depth(btree1)
# => 3

btree2 =  [3, 9, 20, nil, nil, 15, 7, nil, nil, nil, nil, 4, 5]
max_depth(btree2)
# => 4


# 1.1 Implement the same function for a tree as a linked node class.

# Definition for a binary tree node
class TreeNode
  attr_accessor :val, :left, :right

  def initialize(val)
    @val = val
    @left, @right = nil, nil
  end

  def to_a
    def traverse(node, array, i = 0)
      unless node.nil?
        left_i = 2*i + 1
        right_i = 2*i + 2

        array[i] = node.val
        array[left_i] = node.left&.val
        array[right_i] = node.right&.val

        traverse(node.left, array, left_i)
        traverse(node.right, array, right_i)
      end
      array
    end

    result = traverse(self, [])
    result.pop while result.last.nil?
    result
  end

  def self.from_a(array)
    def self.build(array, i = 0)
      if i < array.length
        left_i = 2*i + 1
        right_i = 2*i + 2

        root = array[i]
        left = array[left_i]
        right = array[right_i]

        unless root.nil?
          root_node = TreeNode.new(root)
          root_node.left = build(array, left_i) unless left.nil?
          root_node.right = build(array, right_i) unless right.nil?
          root_node
        end
      end
    end

    build(array)
  end
end

def max_btree_depth(root)
  def traverse_btree(node, depth = 0)
    unless node.nil?
      depth += 1
      left_depth = node.left.nil? ? depth : traverse_btree(node.left, depth)
      right_depth = node.right.nil? ? depth : traverse_btree(node.right, depth)

      depth = right_depth > left_depth ? right_depth : left_depth
    end
    depth
  end

  traverse_btree(root)
end

btree3 = TreeNode.from_a(btree1)
max_btree_depth(btree3)
# => 3

btree4 = TreeNode.from_a(btree2)
max_btree_depth(btree4)
# => 4


# 2. Given an array where elements are sorted in ascending order, convert it to a height balanced BST.
#
# For this problem, a height-balanced binary tree is defined as a binary tree in which the depth of the two subtrees
# of every node never differ by more than 1.
#
# Example:
# Given the sorted array: [-10, -3, 0, 5, 9],
# One possible answer is: [0, -3, 9, -10, nil, 5], which represents the following height balanced BST:
#
#       0
#      / \
#   -3   9
#   /   /
# -10  5

def sorted_array_to_bst(nums)
  def build(nums)
    length = nums.length
    if length == 1
      TreeNode.new(nums[0])
    else
      i = nums.length / 2
      node = TreeNode.new(nums[i])
      node.left = build(nums[0..i - 1]) if length > 1
      node.right = build(nums[i + 1..nums.length - 1]) if length > 2
      node
    end
  end

  return nums if nums.empty?
  build(nums)
end

nums = [-10, -3, 0, 5, 9]
sorted_array_to_bst(nums).to_a
# => [0, -3, 9, -10, nil, 5]