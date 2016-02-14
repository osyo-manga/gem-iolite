require "iolite"
require "iolite/adaptored/iolite_lazy_call_with_self"
require "iolite/adaptored/object_with_to_lazy"

include Iolite::Placeholders
include Iolite::Statement


puts if_else(arg1 == 0, 1, arg1 * self_(arg1 - 1)).call(5)
# => 120
