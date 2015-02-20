require "iolite/functinal/invoke"

module Iolite module Functinal
	def bind func, *args_
		Iolite.lambda { |*args|
# 			func.call(*invoke_a(args_, *args))
			invoke(func, *args).call(*invoke_a(args_, *args))
# 			func.call(*args).call(*invoke_a(args_, *args))
		}
	end
	module_function :bind
end end
