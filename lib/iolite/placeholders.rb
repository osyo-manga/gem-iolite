require "iolite/lambda"

module Iolite module Placeholders
	include Lambda

	def args
		Lambda::Wrapper.new { |*args|
			args
		}
	end
	module_function :args

	def argument index
		expr = Lambda::Wrapper.new { |*args|
			args[index]
		}
# 		def expr.bind *lambdas
# 			Lambda::Wrapper.new { |*args|
# 				Iolite::Functinal.invoke(Iolite::Functinal.invoke(self, *args), *Iolite::Functinal.invoke_a(lambdas, *args))
# 			}
# 		end
		expr
	end
	module_function :argument

	def arg1
		argument 0
	end
	module_function :arg1

	def arg2
		argument 1
	end
	module_function :arg2

	def arg3
		argument 2
	end
	module_function :arg3

	def arg4
		argument 3
	end
	module_function :arg4

	def arg5
		argument 4
	end
	module_function :arg5
end end
