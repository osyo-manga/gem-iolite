require "iolite/functinal/bind"

class Symbol
	def call *args
		Iolite::Functinal.bind(method(self), *args)
	end
end

