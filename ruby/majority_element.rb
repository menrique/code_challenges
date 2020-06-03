# Given an array of size n, find the majority element. The majority element is the element that appears more than
# ⌊ n/2 ⌋ times. You may assume that the array is non-empty and the majority element always exist in the array.
#
# Example
# Input: [2, 2, 1, 1, 2, 2, 2, 1, 1]
# Output: 2

def majority_element(nums)
  counters = {}
  length = nums.length
  nums.inject(counters) do |result, n|
    prev_count = result[n] || 0
    count = (result[n] = prev_count + 1)
    count > length / 2 ? break : result
  end
  counters.max_by{|_, counter| counter}.first
end

nums = [2, 2, 1, 1, 2, 2, 2, 1, 1]
majority_element(nums)
# => 2