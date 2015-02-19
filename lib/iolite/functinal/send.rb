require "iolite/functinal/invoke"

module Iolite module Functinal
	def send func, method, *args_, &block
		Lambda.new { |*args|
			invoke(func, *args).send(method, *invoke_a(args_, *args), &block)
# 			func.call(*args).send(method, *invoke_a(args_, *args), &block)
		}
	end
	module_function :send
end end
