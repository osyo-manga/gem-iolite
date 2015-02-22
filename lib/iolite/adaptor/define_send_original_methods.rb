require "iolite/functinal/send"

class Module
	def iolite_define_send_original_methods prefix = "_"
		methods.each{ |method|
			next if method !~ /\w/
			define_method("#{prefix + method.to_s}"){ |*args|
				Iolite::Functinal.send(self, method, *args)
			}
		}
	end
end

module Iolite module Adaptor
	module DefineSendOriginalMethods
		iolite_define_send_original_methods
	end
end end
