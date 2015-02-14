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
			args[index-1]
		}
# 		def expr.bind *lambdas
# 			Lambda::Wrapper.new { |*args|
# 				Iolite::Functinal.invoke(Iolite::Functinal.invoke(self, *args), *Iolite::Functinal.invoke_a(lambdas, *args))
# 			}
# 		end
		expr
	end
	module_function :argument

	def prepare n
		1.upto(n).each { |i|
			define_method("arg#{i}") do
				argument i
			end
			module_function "arg#{i}"
			alias_method "_#{i}", "arg#{i}"
		}
	end
	module_function :prepare
	prepare(10)
end end
