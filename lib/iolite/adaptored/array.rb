require "iolite/adaptor/all"
require "iolite/functinal/invoke"

class Array
	include Iolite::Adaptor::ToProc
	include Iolite::Adaptor::Bind
	include Iolite::Adaptor::Apply
	include Iolite::Adaptor::Callable
	def call *args
		Iolite::Functinal.invoke_a(self, *args)
	end
end
