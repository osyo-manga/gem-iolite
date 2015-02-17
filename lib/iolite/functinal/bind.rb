module Iolite module Functinal
	def bind func, *args_
		func.class.new { |*args|
			func.call(*invoke_a(args_, *args))
		}
	end
	module_function :bind
end end
