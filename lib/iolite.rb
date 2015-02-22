require "iolite/version"
require "iolite/adaptor"
require "iolite/functinal"
require "iolite/lambda"
require "iolite/placeholders"
require "iolite/statement"
require "iolite/symbol"

# Not support 1.9.x
# require "iolite/refinements"

module Iolite
	include Functinal
	include Statement
end
