require "iolite/lazy"
require "iolite/functinal"

module Iolite module Statement

	class IfThenElse
		def initialize cond, then_
			@cond = cond
			@then_ = then_
		end

		def [](*else_)
			Iolite.lazy { |*args|
				if Iolite::Functinal.invoke(@cond, *args)
					Iolite::Functinal.invoke_a(@then_, *args).last
				else
					Iolite::Functinal.invoke_a(else_, *args).last
				end
			}
		end
	end

	class If
		def initialize cond
			@cond = cond
		end

		def [](*then_)
			if_then = Iolite::Lazy.new { |*args|
				if Iolite::Functinal.invoke(@cond, *args)
					Iolite::Functinal.invoke_a(then_, *args).last
				end
			}
			cond = @cond
			(class << if_then; self; end).class_eval {
				define_method(:else_) {
					IfThenElse.new cond, then_
				}
			}
			if_then
		end
	end

	def if_ cond
		If.new cond
	end

end end
