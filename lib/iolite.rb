require "iolite/version"
require "iolite/adaptor"
require "iolite/functinal"
require "iolite/lambda"
require "iolite/placeholders"
require "iolite/statement"

module Iolite
	def lambda &block
		Iolite::Lambda::Block.new &block
	end
	module_function :lambda

	def wrap value
		Iolite::Lambda::Block.new { |*args| value }
	end
	module_function :wrap
end
