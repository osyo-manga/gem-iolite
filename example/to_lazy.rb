require "iolite"

require "iolite/refinements/object_with_to_lazy"
using Iolite::Refinements::ObjectWithToLazy

# Using 1.9.x
# require "iolite/adaptored/object_with_to_lazy"


include Iolite::Placeholders


class X
	def plus a, b
		a + b
	end
end

x = X.new

# To to_lazy object
# to_lazy return "Iolite.lambda { |*args| self }"
to_lazy_x = x.to_lazy

# To to_lazy function
to_lazy_f = to_lazy_x.plus(arg1, arg2)

puts to_lazy_f.call(1, 2)
# => 3


str = "saya."
["homu", "mami", "mado"].each &str.to_lazy.concat(arg1 + ".")
puts str
# => saya.homu.mami.mado.


