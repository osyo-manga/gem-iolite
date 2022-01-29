# frozen_string_literal: true

require_relative "./iolite/version.rb"
require_relative "./iolite/lazy.rb"
require_relative "./iolite/to_lazyable.rb"

module Iolite
  module Placeholders
    (1..10).each { |num|
      eval <<~EOS
        private def arg#{num}
          Lazy.new { |*args| args[#{num-1}] }
        end
      EOS
    }
  end
  include Placeholders

  refine ::Kernel do
    if defined? import_methods
      import_methods Placeholders
      import_methods Lazyable
    else
      include Placeholders
      include Lazyable
    end
  end
end
