# Compare lambda_driver and iolite
# lambda_driver : http://yuroyoro.github.io/lambda_driver/
# http://yuroyoro.hatenablog.com/entry/2013/03/27/190640

require "iolite"
require "lambda_driver"

include Iolite::Placeholders
using Iolite::Refinements::ObjectWithToLazy


###########################################################
# default
[:foo, :bar, :baz].map{|s| s.to_s }.map{|s| s.upcase }
# or
[:foo, :bar, :baz].map(&:to_s).map(&:upcase)
# => ["FOO",  "BAR",  "BAZ"]

# lambda_driver
[:foo, :bar, :baz].map(&:to_s >> :upcase )

# iolite
[:foo, :bar, :baz].map &arg1.to_s.upcase


###########################################################
# default
[:foo, :hoge, :bar, :fuga].select{|s| s.to_s.length > 3}
# => [:hoge, :fuga]

# lambda_driver
[:foo, :hoge, :bar, :fuga].select(&:to_s >> :length >> 3._(:<))

# iolite
[:foo, :hoge, :bar, :fuga].select &arg1.to_s.length > 3


###########################################################
# default
(1..10).select { |it| it % 2 == 0 }
# => [2, 4, 6, 8, 10]

# lambda_driver
(1..10).select &(:% * 2) >> (:== * 0)

# iolite
(1..10).select &arg1 % 2 == 0


###########################################################
def twice n
	n + n
end

# default
puts twice(10).to_s.length

# lambda_driver
_.twice >> :to_s >> :length >> _.puts < 10

# iolite
using Iolite::Refinements::ObjectWithToLazy
to_l.puts(to_l.twice(arg1).to_s.length).call(10)



