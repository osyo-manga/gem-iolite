require "iolite/adaptor"

module Iolite module Lambda
	class Block
		include Iolite::Adaptor::All

		def initialize &block
			@block = block
		end

		def call *args
			@block.call(*args)
		end
	end
end end
