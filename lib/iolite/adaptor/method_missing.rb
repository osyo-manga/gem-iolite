require "iolite/functinal/send"

module Iolite module Adaptor
	module MethodMissing
		def method_missing name, *args
			Functinal.send(self, name, *args)
		end
		module_function :method_missing
	end
end end
