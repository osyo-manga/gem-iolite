require "iolite/functinal/bind"

module Iolite module Adaptor
	module Bind
		def bind *args
			Functinal.bind(Iolite.lazy { |*args| self }, *args)
		end
	end
end end
