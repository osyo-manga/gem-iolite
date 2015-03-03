require "iolite/version"
require "iolite/adaptor"
require "iolite/functinal"
require "iolite/lazy"
require "iolite/placeholders"
require "iolite/statement"

# Not support 1.9.x
require "iolite/refinements" if RUBY_VERSION.to_f > 2.0

module Iolite
	include Functinal
	include Statement
end
