require "iolite/functinal"

class Array
	def to_proc
		Proc.new { |*args|
			Iolite::Functinal.invoke_a(self, *args)
		}
	end
end

