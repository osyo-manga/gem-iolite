
module Iolite module Functinal
	def self.invoke(expr, *args)
		expr.callable_by_iolite_lambda? ? expr.call(*args) : expr
	end

	def self.invoke_a exprs, *args
		exprs.map { |expr| invoke(expr, *args) }
	end
end end


