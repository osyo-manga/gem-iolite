require "iolite/functinal"

class Hash
	def to_proc
		Proc.new { |*args|
			Hash[ self.map { |key, value|
				Iolite::Functinal.invoke_a([key, value], *args)
			} ]
		}
	end
end

