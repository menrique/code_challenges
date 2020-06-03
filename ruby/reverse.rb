# 1. Write a function that reverses a string into a new one
#
def reverse_string(string)
  string.each_char.inject(''){|result, char| result.prepend(char) }
end

string = '0123456789'
reverse_string(string)
# => "9876543210"


# 2. Write a function that reverses a string without allocating memory for the resulting one.
#
def reverse_string!(string)
  return string if string.empty?

  i = 0
  while i <= length / 2 do
    original = string[i]
    mirror = string[-(i + 1)]
    string[i] = mirror
    string[-(i + 1)] = original
    i += 1
  end

  string
end

string = '0123456789'
reverse_string!(string)
# => "9876543210"

string
# => "9876543210"

def reverse_string_fx!(string)
  string.each_char.with_index.with_object(string){|(_, index), result| result.prepend(result.slice!(index)); result}
end

string = '0123456789'
reverse_string_fx!(string)
# => "9876543210"

string
# => "9876543210"


# 3. Write a function that reverses an array into a new one
#
def reverse_array(array)
  array.inject([]){|result, item| result.prepend(item)}
end

array = %w{0 1 2 3 4 5 6 7 8 9 }
reverse_array(array)
# => ["9", "8", "7", "6", "5", "4", "3", "2", "1", "0"]

array
# => ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]


# 4. Write a function that reverses an array without allocating memory for the resulting one.
#
def reverse_array!(array)
  return array if array.empty?

  i = 0
  while i <= array.length / 2 do
    original = array[i]
    mirror = array[-(i + 1)]
    array[i] = mirror
    array[-(i + 1)] = original
    i += 1
  end

  array
end

array = %w{0 1 2 3 4 5 6 7 8 9 }
reverse_array!(array)
# => ["9", "8", "7", "6", "5", "4", "3", "2", "1", "0"]

array
# => ["9", "8", "7", "6", "5", "4", "3", "2", "1", "0"]

def reverse_array_2!(array)
  array.each.with_index.with_object(array){|(_, index), result| result.prepend(result.delete_at(index)); result}
end

array = %w{0 1 2 3 4 5 6 7 8 9 }
reverse_array_2!(array)
# => ["9", "8", "7", "6", "5", "4", "3", "2", "1", "0"]

array
# => ["9", "8", "7", "6", "5", "4", "3", "2", "1", "0"]

require 'benchmark'
array = %w{0 1 2 3 4 5 6 7 8 9 }
Benchmark.bmbm(12) do |bm|
  bm.report("Loops:") do
    reverse_array!(array)
  end

  bm.report("Enumerators:") do
    reverse_array_2!(array)
  end
end;nil
#                    user     system      total        real
# Loops:         0.000007   0.000002   0.000009 (  0.000005)
# Enumerators:   0.000009   0.000001   0.000010 (  0.000009)
