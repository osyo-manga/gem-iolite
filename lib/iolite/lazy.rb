module Iolite
  class Lazy < BasicObject
    using ::Module.new {
      refine ::Object do
        def __iolite_lazy_apply__(*)
          self
        end
        ruby2_keywords(:__iolite_lazy_apply__) if respond_to?(:ruby2_keywords, true)
      end

      refine ::Array do
        def __iolite_lazy_apply__(*args, &block)
          map { |it| it.__iolite_lazy_apply__(*args, &block) }
        end
        ruby2_keywords(:__iolite_lazy_apply__) if respond_to?(:ruby2_keywords, true)
      end

      refine ::Hash do
        def __iolite_lazy_apply__(*args, &block)
          to_h { |key, value| [key.__iolite_lazy_apply__(*args, &block), value.__iolite_lazy_apply__(*args, &block)] }
        end
        ruby2_keywords(:__iolite_lazy_apply__) if respond_to?(:ruby2_keywords, true)
      end

      refine ::Iolite::Lazy do
        def __iolite_lazy_apply__(*args, &block)
          call(*args, &block)
        end
        ruby2_keywords(:__iolite_lazy_apply__) if respond_to?(:ruby2_keywords, true)

        def __kernel_send__(name, *args, &block)
          ::Kernel.instance_method(name).bind(self).call(*args, &block)
        end
        ruby2_keywords(:__kernel_send__) if respond_to?(:ruby2_keywords, true)
      end
    }
    undef_method :==, :!=, :!

    def initialize &block
      @block = block
    end

    def call(*args, **kwd, &block)
      @block.call(*args, **kwd, &block)
    end

    def __lazy_send__(name, *args, **kwd, &block)
      ::Iolite::Lazy.new { |*args_, &block_|
        applyed_args = args.__iolite_lazy_apply__(*args_, &block_)
        applyed_kwd = kwd.__iolite_lazy_apply__(*args_, &block_)
        if kwd.empty?
          call(*args_, &block_).send(name, *applyed_args, &block)
        else
          call(*args_, &block_).send(name, *applyed_args, **applyed_kwd, &block__)
        end
      }
    end

    def method_missing(name, *args, &block)
      super if name == :to_hash && ::RUBY_VERSION < "3.0.0"
      __lazy_send__(name, *args, &block)
    end
    ruby2_keywords(:method_missing) if respond_to?(:ruby2_keywords, true)

    def to_proc
      __kernel_send__(:method, :call).to_proc.tap { |prc|
        prc.singleton_class.class_eval {
          alias_method :__iolite_lazy_apply__, :call
        }
      }
    end

    # Add support hoge(arg1 => arg2).call(:a, 42) # => hoge(a: 43)
    def hash
      __kernel_send__(:hash)
    end
  end
end
