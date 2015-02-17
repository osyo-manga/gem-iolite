require "iolite/functinal/send"

class Module
	def define_iolite_functinal_send_method send_name, define_name = send_name
		define_method(define_name) { |*args|
			Iolite::Functinal.send(self, send_name, *args)
		}
	end
end
