require "iolite/functinal"

class Hash
	def to_proc
		Proc.new { |*args|
			Hash[ self.map { |key, value|
				[key, Iolite::Functinal.invoke(value, *args)]
			} ]
		}
	end
end

