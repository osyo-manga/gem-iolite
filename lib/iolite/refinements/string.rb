require "iolite/adaptor/all"
require "iolite/functinal/invoke"

module Iolite module Refinements
	module String
		refine ::String do
			include Iolite::Adaptor::ToProc
			include Iolite::Adaptor::Callable
			def call *args
				result = self.clone
				args.each_with_index { |it, i|
					result.gsub! Iolite::Placeholders.const_get("ARG#{i+1}").to_s, it.to_s
				}
				result
			end

			def to_call_by_eval
				Iolite.lambda { |*args|
					gsub(/#{'#{(.*?)}'}/) {
						eval($1).call(*args)
					}
				}
			end
		end
	end
end end
