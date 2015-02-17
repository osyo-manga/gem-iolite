require "iolite/adaptor/callable"
require "iolite/adaptor/bind"
require "iolite/adaptor/send"
require "iolite/adaptor/to_proc"
require "iolite/adaptor/apply"
require "iolite/adaptor/operators"
require "iolite/adaptor/method_missing"

module Iolite module Adaptor
	module All
		include Callable
		include Bind
		include Send
		include MethodMissing
		include ToProc
		include Apply
		include Operators
	end
end end
