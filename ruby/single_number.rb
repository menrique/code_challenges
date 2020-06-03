# 1. Given a non-empty array of integers, every element appears twice except for one. Find that single one.

def single_number(numbers)
  numbers.find{|num| numbers.one?{|n| n == num}}
end

numbers = [1,2,3,4,2,3,1]
single_number(numbers)
# => 4