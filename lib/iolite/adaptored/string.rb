require "iolite/placeholders"

class String
	include Iolite::Adaptor::ToProc
	include Iolite::Adaptor::Callable
	def call *args
		result = self.clone
		args.each_with_index { |it, i|
			result.gsub! Iolite::Placeholders.const_get("ARG#{i+1}").to_s, it.to_s
		}
		result
	end
end
