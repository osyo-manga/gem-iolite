require "iolite/adaptor/all"

module Iolite module Refinements
	module Proc
		refine ::Proc do
			include Iolite::Adaptor::All
		end
	end
end end
