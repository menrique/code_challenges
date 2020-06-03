# Definition for singly-linked list.
class ListNode
  attr_accessor :val, :next

  def initialize(val)
    @val = val
    @next = nil
  end

  def self.from_a(array)

    def self.new_node(array, i)
      unless (val = array[i]).nil?
        node = ListNode.new(val)
        node.next = new_node(array, i + 1)
        node
      end
    end

    new_node(array, 0)
  end

  def to_a
    result = []
    item = self

    until item.nil? do
      result << item.val
      item = item.next
    end

    result
  end

  def clone

    def copy(node)
      unless node.nil?
        facsimile = ListNode.new(node.val)
        facsimile.next = copy(node.next)
        facsimile
      end
    end

    copy(self)
  end
end

# 1. Write a function that reverses a linked list without allocating memory for the resulting one.
#
# Example:
# Input: "0"->"1"->"2"->"3"->"4"->"5"->"6"->"7"->"8"->"9"->nil
# Output: "9"->"8"->"7"->"6"->"5"->"4"->"3"->"2"->"1"->"0"->nil

def reverse_list(head)

  def invert(node, prev = nil)
    return prev if node.nil?
    nxt = node.next
    node.next = prev
    invert(nxt, node)
  end

  invert(head.clone)
end

array = %w{0 1 2 3 4 5 6 7 8 9}
head = ListNode.from_a(array)
head.to_a
# => ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]

reverse_list(head).to_a
# => ["9", "8", "7", "6", "5", "4", "3", "2", "1", "0"]

head.to_a
# => ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]


# 2. Write a function that reverses a linked list into a new one.
#
def reverse_list!(head)

  def invert(node, prev = nil)
    return prev if node.nil?
    nxt = node.next
    node.next = prev
    invert(nxt, node)
  end

  invert(head)
end

array = %w{0 1 2 3 4 5 6 7 8 9}
head = ListNode.from_a(array)
head.to_a
# => ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]

reverse_list!(head).to_a
# => ["9", "8", "7", "6", "5", "4", "3", "2", "1", "0"]

head.to_a
# => ["0"]


# 3. Write a function to delete a node in a singly linked list returning the remaining items as fallows:
#
# Input: list = 4->5->1->9, val = 5
# Output: 4->1->9
#
# Input: list = 4->5->1->9, val = 4
# Output: 5->1->9
#
# Input: list = 4->5->1->9, val = 9
# Output: 4->5->1
#
# All of the nodes' values will be unique.

def delete(head, val)
  prev = nil
  result = head
  cursor = result

  while !cursor.nil? && cursor.val != val do
    prev = cursor
    cursor = cursor.next
  end

  # Empty list or not found
  if cursor.nil?
    # Nothing to delete :)

  # First element
  elsif prev.nil?
    result = cursor.next
    cursor.next = nil

  # Last element
  elsif cursor.next.nil?
    prev.next = nil

  # In between
  else
    prev.next = cursor.next
  end

  result
end

head = ListNode.from_a(%w{4 5 1 9})
delete(head, '5').to_a
# => ["4", "1", "9"]

head.to_a
# => ["4", "1", "9"]

head = ListNode.from_a(%w{4 5 1 9})
delete(head, '4').to_a
# => ["5", "1", "9"]

head.to_a
# => ["4"]

head = ListNode.from_a(%w{4 5 1 9})
delete(head, '9').to_a
# => ["4", "1", "5"]

head.to_a
# => ["4", "1", "5"]

head = ListNode.from_a(%w{1})
delete(head, '1').to_a
# => []

head.to_a
# => [1]

# 4. Merge two sorted linked lists and return it as a new list. The new list should be made by splicing together the
# nodes of the first two lists.
#
# Example 1:
# Input: 1->2->4, 1->3->4
# Output: 1->1->2->3->4->4
#
# # Example 2:
# # Input: 1->2->3->8->9, 4->5->6->7
# # Output: 1->2->3->4->5->6->7->8->9

def merge_sorted_lists(l1, l2)
  result = nil
  current = nil
  n1 = l1
  n2 = l2

  until n1.nil? && n2.nil?

    if (n2.nil? && !n1.nil?) || (n1.val < n2.val)
      new = ListNode.new(n1.val)
      n1 = n1.next
    else
      new  = ListNode.new(n2.val)
      n2 = n2.next
    end

    current = current.nil? ? new : current.next = new
    result ||= current
  end

  result
end

l1 = ListNode.from_a([1, 2, 4])
l2 = ListNode.from_a([1, 3, 4])
merge_sorted_lists(l1, l2).to_a
# => [1, 1, 2, 3, 4, 4]

l1 = ListNode.from_a([1, 2, 3, 8, 9])
l2 = ListNode.from_a([4, 5, 6, 7])
merge_sorted_lists(l1, l2).to_a
# => [1, 2, 3, 4, 5, 6, 7, 8, 9]
