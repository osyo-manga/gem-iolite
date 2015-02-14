
class Module
	def iolite_adaptor_callable flag = nil
		if flag
			define_method(:callable_by_iolite_lambda?) {
				self.respond_to?(:call)
			}
		else
			define_method(:callable_by_iolite_lambda?) {
				flag
			}
		end
	end
end


class Object
	iolite_adaptor_callable false
end


# class Proc
# # 	iolite_adaptor_callable
# 	def bind *args
# 		Iolite::Lambda::Wrapper.new(&self).bind(*args)
# 	end
# end

require "iolite/lambda"


class Symbol
	iolite_adaptor_callable false

	def call *args
		Iolite::Lambda::Wrapper.new(&method(self)).bind(*args)
	end
end

