
# invoke call function
def invoke func, *args
	func.respond_to?(:call) ? func.call(*args) : func
end

class Proc
	# send method
	def send symbol, *args_
		Proc.new { |*args|
			self.call(*args).send(symbol, *args_.map{ |it| invoke(it, *args) })
		}
	end

	# call any method
	def method_missing symbol, *args
		send(symbol, *args)
	end
end


# return args[N]
arg1 = Proc.new { |*args| args[0] }
arg2 = Proc.new { |*args| args[1] }


# assemble expr
f = arg1 + arg2

# apply expr
result = f.call(1, 2)
# => 3

# call
# 1. (arg1 + arg2).call(1, 2)
# 2. arg1.send(:+, arg2).call(1, 2)
# 3. invoke(arg1, 1, 2).send(invoke(:+, 1, 2), invoke(arg2, 1, 2))
# 4. arg1.call(1, 2).send(:+, arg2.call(1, 2))
# 5. [1, 2][0].send(:+, [1, 2][1])
# 6. 1.send(:+, 2)
# 7. 3

