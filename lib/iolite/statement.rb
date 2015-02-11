require "iolite/lambda"
require "iolite/functinal"

module Iolite module Statement
	def if_else cond, then_, else_
		Lambda::Wrapper.new { |*args|
			if Functinal.eval(cond, *args)
				Functinal.eval(then_, *args)
			else
				Functinal.eval(else_, *args)
			end
		}
	end
end end
