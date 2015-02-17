require "iolite/functinal/apply"

module Iolite module Adaptor
	module Apply
		def apply *args, &block
			Functinal.apply(self, *args, &block)
		end
	end
end end
