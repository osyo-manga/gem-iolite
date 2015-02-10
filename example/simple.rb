require "iolite"


#######################################
# Using block
#######################################

p (1..5).map { |it| it + 3 }
# => [4, 5, 6, 7, 8]

p (1..5).inject { |memo, item| memo + item }
# => 15

p ["homu", "mami", "an"].inject(0) { |memo, item| memo + item.length }
# => 10

p [{name: :homu}, {name: :mami}].map { |it| it[:name] }
# => [:homu, :mami]


#######################################
# Using iolite
#######################################

# using arg1, arg2...
include Iolite::Placeholders

p (1..5).map &arg1 + 3
# => [4, 5, 6, 7, 8]

p (1..5).inject &arg1 + arg2
# => 15

p ["homu", "mami", "an"].inject 0, &arg1 + arg2.length
# => 10

p [{name: :homu}, {name: :mami}].map &arg1[:name]
# => [:homu, :mami]


