require "iolite/functinal"
require "iolite/adaptor"

module Iolite module Lambda
	class Wrapper
		# alias Object methods to _{method}
		methods.each{ |method|
			next if method !~ /\w/
			define_method("_#{method}"){ |*args|
				send(method, *args)
			}
		}

		# callable by Functinal.invoke
		iolite_adaptor_callable true

		def initialize &block
			@block = block
		end

		def call *args
			@block.call(*args)
		end

		def to_proc
			Proc.new { |*args|
				self.call(*args)
			}
		end

		def bind *lambdas
			Wrapper.new { |*args|
				self.call(*Functinal.invoke_a(lambdas, *args))
			}
		end

		def send symbol, *args
			Wrapper.new { |*args_|
				self.call(*args_).send(symbol, *Functinal.invoke_a(args, *args_))
			}
# 			Wrapper.new(&:send).bind(self, symbol, *args)
		end

		def method_missing method, *args
			send(method, *args)
		end

		def apply *args
			Wrapper.new(&:call).bind(self, *args)
		end

		# ==
		def == *args
			send(:==, *args)
		end

		# =~
		def =~ *args
			send(:=~, *args)
		end

		# !
		def ! *args
			send(:!, *args)
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
