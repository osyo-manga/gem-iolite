module Iolite module Functinal
	def send func, method, *args_, &block
		func.class.new { |*args|
			func.call(*args).send(method, *invoke_a(args_, *args), &block)
		}
	end
	module_function :send
end end
