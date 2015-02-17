require "iolite/functinal/bind"

module Iolite module Functinal
	def apply func, *args, &block
		Functinal.bind(func.class.new(&:call), func, *args, &block)
	end
	module_function :apply
end end
