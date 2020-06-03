# 1. Given two strings s and t , write a function to determine if t is an anagram of s.
#
# Example 1:
# Input: s = "anagram", t = "nagaram"
# Output: true
#
# Example 2:
# Input: s = "rat", t = "car"
# Output: false
#
# Note:
# You may assume the string contains only lowercase alphabets.
#
# Follow up:
# What if the inputs contain unicode characters? How would you adapt your solution to such case?

def is_anagram?(s, t)
  (w1 = s.split('').sort) == (w2 = t.split('').sort) || w1.map(&:downcase) == w2.map(&:downcase)
end

s = 'anagram'
t = 'nagaram'

is_anagram?(s, t)
# => true

s = "rat"
t = "car"

is_anagram?(s, t)
# => false