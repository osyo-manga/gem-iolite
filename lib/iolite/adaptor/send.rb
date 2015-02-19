require "iolite/functinal/send"
require "iolite/functinal/invoke"

module Iolite module Adaptor
	module Send
		def send *args, &block
			Functinal.send(self, *args, &block)
		end
	end
end end
