require "iolite/functinal/define_iolite_functinal_send_method"

module Iolite module Adaptor
	module Operators
		define_iolite_functinal_send_method :==
		define_iolite_functinal_send_method :=~
		define_iolite_functinal_send_method :!
		define_iolite_functinal_send_method :!=
		define_iolite_functinal_send_method :!~
		define_iolite_functinal_send_method :===

		# &&
		def product rhs
			Lazy.new { |*args|
				Functinal.invoke(self, *args) && Functinal.invoke(rhs, *args)
			}
		end
		alias_method :andand, :product

		# ||
		def disjunction rhs
			Lazy.new { |*args|
				Functinal.invoke(self, *args) || Functinal.invoke(rhs, *args)
			}
		end
		alias_method :oror, :disjunction
	end
end end
