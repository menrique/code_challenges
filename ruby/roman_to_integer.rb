# Roman numerals are represented by seven different symbols: I, V, X, L, C, D and M.
# Symbol       Value
# I             1
# V             5
# X             10
# L             50
# C             100
# D             500
# M             1000
# For example, two is written as II in Roman numeral, just two one's added together. Twelve is written as, XII, which is
# simply X + II. The number twenty seven is written as XXVII, which is XX + V + II.
#
# Roman numerals are usually written largest to smallest from left to right. However, the numeral for four is not IIII.
# Instead, the number four is written as IV. Because the one is before the five we subtract it making four. The same
# principle applies to the number nine, which is written as IX. There are six instances where subtraction is used:
#
# I can be placed before V (5) and X (10) to make 4 and 9.
# X can be placed before L (50) and C (100) to make 40 and 90.
# C can be placed before D (500) and M (1000) to make 400 and 900.
# Given a roman numeral, convert it to an integer. Input is guaranteed to be within the range from 1 to 3999.
#
# Example 1:
# Input: "III"
# Output: 3
#
# Example 2:
# Input: "IV"
# Output: 4
#
# Example 3:
# Input: "IX"
# Output: 9
#
# Example 4:
# Input: "LVIII"
# Output: 58
# Explanation: L = 50, V= 5, III = 3.
#
# Example 5:
# Input: "MCMXCIV"
# Output: 1994
# Explanation: M = 1000, CM = 900, XC = 90 and IV = 4.

def roman_to_int(roman)
  result = 0
  length = roman.length
  i = 0

  while i < length do
    current = roman[i]
    nxt = roman[i + 1]

    if current == 'C' && nxt == 'M'
      result += 900
      i += 1

    elsif current == 'M'
      result += 1000

    elsif  current == 'C' && nxt == 'D'
      result += 400
      i += 1

    elsif current == 'D'
      result += 500

    elsif current == 'X' && nxt == 'C'
      result += 90
      i += 1

    elsif current == 'C'
      result += 100

    elsif current == 'X' && nxt == 'L'
      result += 40
      i += 1

    elsif current == 'L'
      result += 50

    elsif current == 'I' && nxt == 'X'
      result += 9
      i += 1

    elsif current == 'X'
      result += 10

    elsif current == 'I' && nxt == 'V'
      result += 4
      i += 1

    elsif current == 'V'
      result += 5

    elsif current == 'I'
      result += 1
    end

    i += 1
  end

  result
end

roman = 'III'
roman_to_int(roman)
# => 3

roman = 'IV'
roman_to_int(roman)
# => 4

roman = 'IX'
roman_to_int(roman)
# => 9

roman = 'LVIII'
roman_to_int(roman)
# => 58

roman = 'MCMXCIV'
roman_to_int(roman)
# => 1994