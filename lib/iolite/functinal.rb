require "iolite/lambda"

module Iolite module Functinal
	def invoke(expr, *args)
		expr.callable_by_iolite_lambda? ? expr.call(*args) : expr
	end
	module_function :invoke

	def invoke_a exprs, *args
		exprs.map { |expr| invoke(expr, *args) }
	end
	module_function :invoke_a

	def value val
		Iolite.lambda { |*args| val }
	end
	module_function :value
end end


