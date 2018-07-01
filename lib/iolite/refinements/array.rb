require "iolite/adaptor/all"
require "iolite/functinal/invoke"

module Iolite module Refinements
	module Array
		refine ::Array do
			include Iolite::Adaptor::Bind
			include Iolite::Adaptor::Apply

			def call *args, &block
				Iolite::Functinal.invoke_a(self, *args, &block)
			end

			def as_proc
				Iolite::Lazy.new do |*args, &block|
					self.call(*args, &block)
				end
			end
		end
	end
end end
