require "iolite/lambda"
require "iolite/functinal"

module Iolite module Statement
	def if_else cond, then_, else_
		Lambda::Wrapper.new { |*args|
			if Functinal.invoke(cond, *args)
				Functinal.invoke(then_, *args)
			else
				Functinal.invoke(else_, *args)
			end
		}
	end
end end
