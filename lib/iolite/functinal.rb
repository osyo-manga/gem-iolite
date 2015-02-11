
module Iolite module Functinal
	def self.eval(expr, *args)
		expr.callable_by_iolite_lambda? ? expr.call(*args) : expr
	end

	def self.eval_a exprs, *args
		exprs.map { |expr| eval(expr, *args) }
	end
end end


