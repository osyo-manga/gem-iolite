require "iolite/adaptor"

module Iolite
	class Lazy < BasicObject
# 		include ::Iolite::Adaptor::All
		include ::Iolite::Adaptor::Callable
		include ::Iolite::Adaptor::Bind
		include ::Iolite::Adaptor::Send
		include ::Iolite::Adaptor::MethodMissing
		include ::Iolite::Adaptor::ToProc
		include ::Iolite::Adaptor::Apply
		include ::Iolite::Adaptor::Operators
		include ::Iolite::Adaptor::ToLazy

		def initialize &block
			@block = block
		end

		def call *args
			@block.call(*args)
		end

# 		iolite_define_send_original_methods
	end

	def lazy &block
		Iolite::Lazy.new &block
	end
	module_function :lazy

# 	def wrap value
# 		Iolite.lazy { |*args| value }
# 	end
# 	module_function :wrap
#
# 	def lazy_func func
# 		Iolite.lazy { |*args| func.call(*args) }
# 	end
# 	module_function :wrap
end
