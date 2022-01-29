require_relative "./lazy.rb"

module Iolite
  module Lazyable
    def to_lazy
      Iolite::Lazy.new { |*| self }
    end

#     module Array
#       def to_lazy
#         Iolite::Lazy.new { |*args, &block|
#           self.map { |it| it.call(*args, &block)  }
#         }
#       end
#     end
  end
end
