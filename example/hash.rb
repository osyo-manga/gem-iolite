require "iolite"

# Use require
# define Hash#to_proc
require "iolite/adaptor/hash"

include Iolite::Placeholders

p ({arg1 => arg2}).to_proc.call(:name, "homu")
# => {:name=>"homu"}

p ["homu", "mami", "mado"]. map &({ name: arg1 })
# => [{:name=>"homu"}, {:name=>"mami"}, {:name=>"mado"}]

