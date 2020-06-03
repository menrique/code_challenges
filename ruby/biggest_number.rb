# 1. In the language of your choice, write a function that takes 5 numbers in a list and returns the biggest one.

def biggest_number(numbers)
  numbers.inject(numbers.first){|biggest, n| biggest = n if n > biggest; biggest}
end

# Sample
numbers = [14, 8, 15, 17, 13]
biggest_number(numbers)
# => 17