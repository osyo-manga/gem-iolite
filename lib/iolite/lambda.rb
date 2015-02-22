require "iolite/adaptor"

module Iolite
	class Lambda
# 		include Iolite::Adaptor::All
		include Iolite::Adaptor::Callable
		include Iolite::Adaptor::Bind
		include Iolite::Adaptor::Send
		include Iolite::Adaptor::MethodMissing
		include Iolite::Adaptor::ToProc
		include Iolite::Adaptor::Apply
		include Iolite::Adaptor::Operators


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

	def lazy func
		Iolite.lambda { |*args| func.call(*args) }
	end
	module_function :wrap
end
