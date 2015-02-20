require "iolite/functinal/bind"

module Iolite module Adaptor
	module Bind
		def bind *args
			Functinal.bind(lambda { |*args| self }, *args)
		end
	end
end end
