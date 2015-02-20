require "iolite/functinal/bind"

module Iolite module Adaptor
	module Apply
		def apply *args, &block
			Functinal.bind(self, *args, &block)
		end
	end
end end
