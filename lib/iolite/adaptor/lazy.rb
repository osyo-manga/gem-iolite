require "iolite/lambda"

module Iolite module Adaptor
	module Lazy
		def lazy
			Iolite.lambda { |*args| self }
		end
	end
end end
