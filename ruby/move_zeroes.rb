# 1. Given an array nums, write a function to move all 0's to the end of it while maintaining the relative order of the non-zero elements.
#
# Example:
# Input: [0, 1, 0, 3, 12, 0]
# Output: [1, 3, 12, 0, 0, 0]
#
# Note:
# You must do this in-place without making a copy of the array.
# Minimize the total number of operations.

def move_zeroes(nums)
  def carryover(nums, i, times = 1)
    unless times + i > nums.length
      if nums[i] == 0
        nums.append(nums.delete_at(i))
      else
        i += 1
      end
      times += 1
      carryover(nums, i, times)
    end
    nums
  end

  carryover(nums, 0)
end

nums = [0, 1, 0, 3, 12, 0]
move_zeroes(nums)
# => [1, 3, 12, 0, 0, 0]