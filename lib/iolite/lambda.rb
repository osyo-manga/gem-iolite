require "iolite/functinal"
require "iolite/adaptors"

module Iolite module Lambda
	class Wrapper
		iolite_adaptors_callable true

		def initialize &block
			@block = block
		end

		def method_missing method, *args
			self.class.class_eval {
				define_method "#{method}" do |*args_|
					self.class.new(&:"#{method}").bind(self, *args_)
				end
			}
			__send__(method, *args)
		end

		def to_proc
			Proc.new { |*args|
				self.call(*args)
			}
		end

		def call *args
			@block.call(*args)
		end

		def send *lambdas
			Wrapper.new(&:send).bind(self, *lambdas)
		end

		def bind *lambdas
			Wrapper.new { |*args|
				self.call(*Functinal.invoke_a(lambdas, *args))
			}
		end

		def apply *args
			Wrapper.new(&:call).bind(self, *args)
		end

		# &&
		def product rhs
			Wrapper.new { |*args|
				Functinal.invoke(self, *args) && Functinal.invoke(rhs, *args)
			}
		end

		# ||
		def disjunction rhs
			Wrapper.new { |*args|
				Functinal.invoke(self, *args) || Functinal.invoke(rhs, *args)
			}
		end
	end
end end
