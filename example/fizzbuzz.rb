require "iolite"

include Iolite::Placeholders
include Iolite::Statement

fizzbuzz = if_else(
	arg1 % 15 == 0, "FizzBuzz", if_else(
	arg1 %  5 == 0, "Buzz", if_else(
	arg1 %  3 == 0, "Fizz",
	arg1
)))


puts (1..20).map &fizzbuzz


