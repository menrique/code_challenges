# Given a string, find the first non-repeating character in it and return it's index. If it doesn't exist, return -1.
#
# Example 1:
# s = "leetcode"
# return 0.
#
# Example 2:
# s = "loveleetcode",
# return 2.
#
# Note: You may assume the string contain only lowercase letters.

def first_uniq_char(string)
  array = string.chars
  array.index{|char| array.select{|ch| ch == char}.length == 1} || -1
end

string = 'leetcode'
first_uniq_char(string)
# => 0

string = 'loveleetcode'
first_uniq_char(string)
# => 2

def first_uniq_char_2(string)
  result = nil
  string.each_char.with_index do |char, index|
    if string.scan(char).length == 1
      result = index
      break
    end
  end
  result || -1
end

string = 'leetcode'
first_uniq_char_2(string)
# => 0

string = 'loveleetcode'
first_uniq_char_2(string)
# => 2

require 'benchmark'
string = '1122334455667788990'
Benchmark.bmbm(10) do |bm|
  bm.report("As Array:") do
    first_uniq_char(string)
  end

  bm.report("As String:") do
    first_uniq_char_2(string)
  end
end;nil
#                  user     system      total        real
# As Array:    0.000040   0.000001   0.000041 (  0.000040)
# As String:   0.000017   0.000001   0.000018 (  0.000016)