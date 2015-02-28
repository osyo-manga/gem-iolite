require "iolite/functinal/invoke"

module Iolite module Functinal
	def send func, method, *args_, &block
		Lazy.new { |*args|
# 			block = invoke(block, *args) if block
			invoke(func, *args).send(method, *invoke_a(args_, *args), &block)
# 			invoke(func, *args).send(method, *invoke_a(args_, *args), &block)
# 			func.call(*args).send(method, *invoke_a(args_, *args), &block)
		}
	end
	module_function :send
end end
