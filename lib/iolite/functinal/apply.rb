require "iolite/functinal/bind"

module Iolite module Functinal
	def apply func, *args_, &block
# 		Functinal.bind(Iolite.lambda(&:call), func, *args, &block)
		Iolite.lambda { |*args|
			func.call(*args).call(*invoke_a(args_, *args))
		}
	end
	module_function :apply
end end
