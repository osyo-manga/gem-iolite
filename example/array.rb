require "iolite"

# Use require
# define Array#to_proc
require "iolite/adaptored/array"

include Iolite::Placeholders

p [1, arg1, 2, arg1 + arg2].to_proc.call(1, 2)
# => [1, 1, 2, 3]

p [1, 2, 3].map &[arg1, arg1 ,arg1]
# => [[1, 1, 1], [2, 2, 2], [3, 3, 3]]

p [1, 2, 3].map &((1..3).map &arg1.to_l + 3)
# => [[4, 4, 4], [5, 5, 5], [6, 6, 6]]

