# Given an array of integers, find if the array contains any duplicates.
#
# Your function should return true if any value appears at least twice in the array, and it should return false if every
# element is distinct.
#
# Example 1:
# Input: [1,2,3,1]
# Output: true
#
# Example 2:
# Input: [1,2,3,4]
# Output: false
#
# Example 3:
# Input: [1,1,1,3,3,4,3,2,4,2]
# Output: true

def contains_duplicate(nums)
  nums.any?{ |n| nums.count{ |m| n == m} > 1}
end

nums = [1,2,3,1]
contains_duplicate(nums)
# => true

nums = [1,2,3,4]
contains_duplicate(nums)
# => false

nums = [1,1,1,3,3,4,3,2,4,2]
contains_duplicate(nums)
# => true

def contains_duplicate_2(nums)
  nums.any?{ |n| nums.select{ |m| n == m}.length > 1}
end

require 'benchmark'
nums = [1,1,1,3,3,4,3,2,4,2]
Benchmark.bmbm(14) do |bm|
  bm.report("Count:") do
    contains_duplicate(nums)
  end

  bm.report("Select/Length:") do
    contains_duplicate_2(nums)
  end
end;nil
#                      user     system      total        real
# Count:           0.000004   0.000001   0.000005 (  0.000003)
# Select/Length:   0.000004   0.000000   0.000004 (  0.000003)