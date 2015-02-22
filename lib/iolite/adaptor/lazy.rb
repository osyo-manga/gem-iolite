require "iolite/lambda"

module Iolite module Adaptor
	module Lazy
		def lazy
			Iolite.lambda { |*args| self }
		end
		alias_method :iolite_lazy, :lazy
	end
end end
