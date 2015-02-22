module Iolite module Adaptor
	module ToProc
		def to_proc
			Proc.new { |*args|
				self.call(*args)
			}
		end
		alias_method :iolite_to_proc, :to_proc
	end
end end
