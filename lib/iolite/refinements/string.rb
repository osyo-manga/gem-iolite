require "iolite/adaptor/all"
require "iolite/functinal/invoke"

module Iolite module Refinements
	module String
		refine ::String do
			def call *args
				gsub(/#{'#Iolite::Lazy{(.*?)}'}/) {
					ObjectSpace._id2ref($1.to_i).call *args
				}
# 				result = self.clone
# 				args.each_with_index { |it, i|
# 					result.gsub! Iolite::Placeholders.const_get("ARG#{i+1}").to_s, it.to_s
# 				}
# 				result
			end

			def to_call_by_eval binding = nil
				Iolite.lambda { |*args|
					gsub(/#{'#{(.*?)}'}/) {
						eval($1, binding).call(*args)
					}
				}
			end
		end

		refine ::Iolite::Lazy do
			def iolite_s
				"#Iolite::Lazy{#{__id__}}"
			end
		end
	end
end end
