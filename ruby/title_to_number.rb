# Given a column title as appear in an Excel sheet, return its corresponding column number.
#
# For example:
# A -> 1
# B -> 2
# C -> 3
# ...
# Z -> 26
# AA -> 27
# AB -> 28
# ...
#
# Example 1:
# Input: "A"
# Output: 1
#
# Example 2:
# Input: "AB"
# Output: 28
#
# Example 3:
# Input: "ZY"
# Output: 701

def title_to_number(title)
  columns = ('A'..'Z').to_a
  index = (columns + columns.map{|col1| columns.map{|col2| "#{col1}#{col2}"}.flatten}.flatten).index(title)
  index.nil? ? 0 : index + 1
end

title = 'A'
title_to_number(title)
# => 1

title = 'AB'
title_to_number(title)
# => 28

title = 'ZY'
title_to_number(title)
# => 701

def title_to_number_2(title)
  columns = ('A'..'Z').to_a
  index = (columns + columns.inject([]){|comb1, col1| columns.inject(comb1){|comb2, col2| comb2 << "#{col1}#{col2}"}}).index(title)
  index.nil? ? 0 : index + 1
end

require 'benchmark'
title = 'ZY'
Benchmark.bmbm(10) do |bm|
  bm.report("Flat Map:") do
    title_to_number(title)
  end

  bm.report("Injection:") do
    title_to_number_2(title)
  end
end;nil
#                  user     system      total        real
# Flat Map:    0.000271   0.000001   0.000272 (  0.000285)
# Injection:   0.000177   0.000001   0.000178 (  0.000177)