module Iolite module Functinal
	def invoke func, *args
		func.respond_to?(:iolite_functinal_invoke_call) ? func.iolite_functinal_invoke_call(*args) : func
	end
	module_function :invoke

	def invoke_a funcs, *args
		funcs.map{ |it| invoke(it, *args) }
	end
	module_function :invoke_a
end end
