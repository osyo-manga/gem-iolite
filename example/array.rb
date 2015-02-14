require "iolite"

# Use require
# define Array#to_proc
require "iolite/adaptor/array"

include Iolite::Placeholders

p [1, arg1, 2, arg1 + arg2].to_proc.call(1, 2)
# => [1, 1, 2, 3]

p [1, 2, 3].map &[arg1, arg1 ,arg1]
# => [[1, 1, 1], [2, 2, 2], [3, 3, 3]]

p [1, 2, 3].map &((1..3).map &value(arg1) + 3)
# => [[1, 1, 1], [2, 2, 2], [3, 3, 3]]

