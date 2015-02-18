require "iolite/adaptor"

module Iolite
	class Lambda
		include Iolite::Adaptor::All

		def initialize &block
			@block = block
		end

		def call *args
			@block.call(*args)
		end
	end

	def lambda &block
		Iolite::Lambda.new &block
	end
	module_function :lambda

	def wrap value
		Iolite.lambda { |*args| value }
	end
	module_function :wrap
end
