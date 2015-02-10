require "iolite/adaptors"

module Iolite module Lambda
	def self.invoke func, *args
		func.callable_by_iolite_lambda? ? func.call(*args) : func
	end

	def self.invoke_a funcs, *args
		funcs.map { |func| Lambda.invoke(func, *args) }
	end

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

		def send lambdas
			Wrapper.new(&:send).bind(self, *lambdas)
		end

		def bind *lambdas
			Wrapper.new { |*args|
				self.call(*Lambda.invoke_a(lambdas, *args))
			}
		end

		# &&
		def product rhs
			Wrapper.new { |*args|
				Lambda.invoke(self, *args) && Lambda.invoke(rhs, *args)
			}
		end

		# ||
		def disjunction rhs
			Wrapper.new { |*args|
				Lambda.invoke(self, *args) || Lambda.invoke(rhs, *args)
			}
		end
	end
end end
