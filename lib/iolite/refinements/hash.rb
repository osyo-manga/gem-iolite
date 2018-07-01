require "iolite/adaptor/all"
require "iolite/functinal/invoke"

module Iolite module Refinements
	module Hash
		refine ::Hash do
			include Iolite::Adaptor::Bind
			include Iolite::Adaptor::Apply
			def call *args
				Hash[ self.map { |key, value|
					Iolite::Functinal.invoke_a([key, value], *args)
				} ]
			end

			def as_proc
				Iolite::Lazy.new do |*args, &block|
					self.call(*args, &block)
				end
			end
		end
	end
end end
