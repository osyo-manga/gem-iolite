require "iolite/adaptor/all"
require "iolite/functinal/invoke"

module Iolite module Refinements
	module Hash
		refine ::Hash do
			include Iolite::Adaptor::ToProc
			include Iolite::Adaptor::Bind
			include Iolite::Adaptor::Apply
			include Iolite::Adaptor::Callable
			def call *args
				Hash[ self.map { |key, value|
					Iolite::Functinal.invoke_a([key, value], *args)
				} ]
			end
		end
	end
end end
