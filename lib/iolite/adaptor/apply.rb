require "iolite/functinal/bind"

module Iolite module Adaptor
	module Apply
		def apply *args, &block
			Functinal.bind(self, *args, &block)
		end
		alias_method :iolite_apply, :apply
	end
end end
