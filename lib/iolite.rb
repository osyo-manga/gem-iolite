require "iolite/version"
require "iolite/lambda.rb"
require "iolite/adaptors.rb"
require "iolite/placeholders.rb"

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
