require "iolite/version"
require "iolite/lambda"
require "iolite/adaptor"
require "iolite/placeholders"
require "iolite/statement"

module Iolite
	def lambda &block
		Iolite::Lambda::Wrapper.new &block
	end
	module_function :lambda

	def wrap value
		Iolite::Lambda::Wrapper.new { |*args| value }
	end
	module_function :wrap
end
