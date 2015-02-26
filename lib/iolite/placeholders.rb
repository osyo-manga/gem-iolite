require "iolite/lambda"

module Iolite module Placeholders
	def args
		Lambda.new { |*args|
			args
		}
	end
	module_function :args

	def argument index
		Lambda.new { |*args|
			args[index-1]
		}
	end
	module_function :argument

	def prepare n
		1.upto(n).each { |i|
			const_set("ARG#{i}", argument(i))
			define_method("arg#{i}") do
				Placeholders.const_get("ARG#{i}")
			end
			module_function "arg#{i}"
			alias_method "_#{i}", "arg#{i}"
		}
	end
	module_function :prepare
	prepare(10)
end end
