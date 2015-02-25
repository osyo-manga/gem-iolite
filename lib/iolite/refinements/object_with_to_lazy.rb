require "iolite/adaptor/to_lazy"

module Iolite module Refinements
	module ObjectWithToLazy
		refine Object do
			include Iolite::Adaptor::ToLazy
		end
	end
end end
