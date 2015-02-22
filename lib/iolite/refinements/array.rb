require "iolite/adaptor/all"
require "iolite/functinal/invoke"

module Iolite module Refinements
	module Array
		refine ::Array do
			include Iolite::Adaptor::ToProc
			include Iolite::Adaptor::Bind
			include Iolite::Adaptor::Apply
			include Iolite::Adaptor::Callable
			def call *args
				Iolite::Functinal.invoke_a(self, *args)
			end
		end
	end
end end
