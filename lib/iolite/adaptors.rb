
class Module
	def iolite_adaptors_callable flag = nil
		if flag == nil
			define_method(:callable_by_iolite_lambda?) {
				self.respond_to?(:call)
			}
		else
			define_method(:callable_by_iolite_lambda?) {
				flag
			}
		end
	end
end


class Object
	iolite_adaptors_callable false
end


module Iolite module Adaptors
	def self.eval(expr, *args)
		expr.callable_by_iolite_lambda? ? expr.call(*args) : expr
	end

	def self.eval_a exprs, *args
		exprs.map { |expr| eval(expr, *args) }
	end
end end


# class Proc
# 	iolite_adaptor_callable
# end

require "iolite/lambda"


class Symbol
	def call *args
		Iolite::Lambda::Wrapper.new(&method(self)).bind(*args)
	end
end

