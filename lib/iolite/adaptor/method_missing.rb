require "iolite/functinal/send"

module Iolite module Adaptor
	module MethodMissing
		def method_missing name, *args, &block
			Functinal.send(self, name, *args, &block)
		end
		module_function :method_missing
	end
end end
