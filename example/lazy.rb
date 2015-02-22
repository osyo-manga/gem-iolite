require "iolite"

require "iolite/refinements/object_with_lazy"
using Iolite::Refinements::ObjectWithLazy

# Using 1.9.x
# require "iolite/adaptored/object_with_lazy"


include Iolite::Placeholders


class X
	def plus a, b
		a + b
	end
end

x = X.new

# To lazy object
# lazy return Iolite.lambda { |*args| self }
lazy_x = x.lazy

# To lazy function
lazy_f = lazy_x.plus(arg1, arg2)

puts lazy_f.call(1, 2)
# => 3


str = "saya"
["homu", "mami", "mado"].each &str.lazy.concat(arg1)
puts str
# => sayahomumamimado


