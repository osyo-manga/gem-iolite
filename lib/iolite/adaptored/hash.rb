require "iolite/adaptor/all"

class Hash
	include Iolite::Adaptor::ToProc
	include Iolite::Adaptor::Bind
	include Iolite::Adaptor::Apply
	include Iolite::Adaptor::Callable
	def call *args
		Hash[ self.map { |key, value|
			Iolite::Functinal.invoke_a([key, value], *args)
		} ]
	end
end

