module Iolite module Adaptor
	module ToProc
		def to_proc
			Proc.new { |*args|
				self.call(*args)
			}
		end
	end
end end
