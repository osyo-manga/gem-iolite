require "iolite/adaptor/lazy"

module Iolite module Refinements
	module ObjectWithLazy
		refine Object do
			include Iolite::Adaptor::Lazy
		end
	end
end end
