#1. Write a program that outputs the string representation of numbers from 1 to n. But for multiples of three it should
# output “Fizz” instead of the number and for the multiples of five output “Buzz”. For numbers which are multiples of
# both three and five output “FizzBuzz”.

def fizz_buzz(n)
  (1..n).map do |num|
    mult_3 = num % 3 == 0
    mult_5 = num % 5 == 0
    if mult_3 && mult_5
      'FizzBuzz'
    elsif mult_3
      'Fizz'
    elsif mult_5
      'Buzz'
    else
      num
    end
  end
end

fizz_buzz(15)
# => [1, 2, "Fizz", 4, "Buzz", "Fizz", 7, 8, "Fizz", "Buzz", 11, "Fizz", 13, 14, "FizzBuzz"]