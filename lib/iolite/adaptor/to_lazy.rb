require "iolite/lambda"

module Iolite module Adaptor
	module ToLazy
		def to_lazy
			Iolite.lambda { |*args| self }
		end
		alias_method :iolite_to_lazy, :to_lazy
		alias_method :to_l, :to_lazy
	end
end end
