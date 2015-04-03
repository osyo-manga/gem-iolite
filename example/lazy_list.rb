require "iolite"

include Iolite::Placeholders

# Using Object#to_lazy
using Iolite::Refinements::ObjectWithToLazy

evens = (1..Float::INFINITY).to_lazy # to lazy list
	.first(arg1).select(&arg1 % 2 == 0)

p evens.call(10)
# => [2, 4, 6, 8, 10]
p evens.call(20)
# => [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]
