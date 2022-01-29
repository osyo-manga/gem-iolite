# frozen_string_literal: true

RSpec.describe Iolite::Lazy do
  describe "#call" do
    class TestLazyObject
      attr_reader :args, :kwd, :block

      def initialize(*args, **kwd, &block)
        @args = args
        @kwd = kwd
        @block = block
      end

      def original_method
        :original_method
      end

      def with_args(a =1 , b = 2, c: 3, d: 4, &block)
        { a: a, b: b, c: c, d: d, block: block }
      end

      private

      def private_method
        :private_method
      end
    end

    let(:lazy_object) {
      Iolite::Lazy.new { |*args, **kwd, &block|
        TestLazyObject.new(*args, **kwd, &block)
      }
    }
    let(:call_args) { [] }
    let(:call_kwd) { {} }
    let(:call_block) { proc {} }
    let(:apply) { lazy_object }
    subject { apply.call(*call_args, **call_kwd, &call_block) }

    context "call #class" do
      let(:apply) { lazy_object.class }
      it { is_expected.to be TestLazyObject }
    end

    context "call undefined method" do
      subject { lazy_object.hogehgoe }
      it { is_expected.to be_kind_of(TestLazyObject) }
    end

    xcontext "call private method" do
      let(:apply) { lazy_object.private_method }
      it { expect { subject }.to raise_error(NoMethodError) }
    end

    context "call #hash" do
      let(:lazy_object) {
        Iolite::Lazy.new { |*| 42 }
      }
      subject { lazy_object.hash }
      it { is_expected.not_to be_kind_of(TestLazyObject) }
    end

    context "call #to_h" do
      let(:lazy_object) {
        Iolite::Lazy.new { |*| 42 }
      }
      subject { lazy_object.to_hash }
      if RUBY_VERSION < "3.0.0"
        it { expect { subject }.to raise_error NoMethodError }
      else
        it { is_expected.to be_kind_of(TestLazyObject) }
      end
    end

    context "call #original_method" do
      let(:apply) { lazy_object.original_method }
      it { is_expected.to be :original_method }
    end

    context "call #with_args" do
      context "with optional args" do
        let(:apply) { lazy_object.with_args(10, 11) }
        it { is_expected.to include(a: 10, b: 11) }
      end

      context "with keyword args" do
        let(:apply) { lazy_object.with_args(c: 10, d: 11) }
        it { is_expected.to include(c: 10, d: 11) }
      end

      context "with block args" do
        let(:block) { proc {} }
        let(:apply) { lazy_object.with_args(&block) }
        it { is_expected.to include(block: block) }
      end

      context "with lazy array" do
        include Iolite
        let(:call_args) { [10, 11, 12] }
        let(:apply) { lazy_object.with_args([arg1, arg2 + arg3]) }
        it { is_expected.to include(a: [10, 23]) }
      end

      context "with lazy hash" do
        include Iolite
        let(:call_args) { [:x, 10, 11] }
        let(:apply) { lazy_object.with_args([{ arg1 => (arg2 + arg3) }]) }
        it { is_expected.to include(a: [{ x: 21 }]) }
      end
    end

    context "call with args" do
      let(:call_args) { [1, 2] }
      it { is_expected.to have_attributes(args: [1, 2]) }
    end

    context "call with keyword" do
      let(:call_kwd) { { a: 1, b: 2 } }
      it { is_expected.to have_attributes(kwd: { a: 1, b: 2 }) }
    end

    context "call with block" do
      let(:block) { proc {} }
      let(:call_block) { block }
      it { is_expected.to have_attributes(block: block) }
    end

    context "call with Lazy object" do
      include Iolite
      let(:call_args) { [10, 11, 12] }

      context "with optional args" do
        let(:apply) { lazy_object.with_args(arg1, arg2 + arg3) }
        it { is_expected.to include(a: 10, b: 11 + 12) }
      end

      context "with keyword args" do
        let(:call_args) { [10, 11, 12, :d] }
        let(:apply) { lazy_object.with_args(c: arg1, arg4 => (arg2 + arg3)) }
        it { is_expected.to include(c: 10, d: 11 + 12) }
      end

      context "with block args" do
        let(:block) { proc { "block" } }
        let(:call_args) { [block] }
        let(:apply) { lazy_object.with_args(&arg1) }
        it { is_expected.to include(block: block) }
      end
    end
  end

  describe "__lazy_send__" do
    let(:lazy_object) {
      Iolite::Lazy.new { |*| 42 }
    }
    let(:apply) { lazy_object }
    subject { apply.__lazy_send__(send_method_name).call }

    context "call #hash" do
      let(:send_method_name) { :hash }
      it { is_expected.to eq 42.hash }
    end
  end

  describe "args" do
    include Iolite

    let(:lazy_object) {  }
    let(:call_args) { [] }
    let(:call_kwd) { {} }
    let(:call_block) { proc {} }
    subject { lazy_object.call(*call_args, **call_kwd, &call_block) }

    context "arg1 + arg2" do
      let(:lazy_object) { arg1 + arg2 }
      let(:call_args) { [1, 2] }
      it { is_expected.to eq 3 }
    end

    context "arg1[arg2]" do
      let(:lazy_object) { arg1[arg2] }
      let(:call_args) { [[1, 2, 3], 2] }
      it { is_expected.to eq 3 }
    end

    context "arg1[arg2 + arg3]" do
      let(:lazy_object) { arg1[arg2 + arg3] }
      let(:call_args) { [[1, 2, 3], 1, 1] }
      it { is_expected.to eq 3 }
    end

    context "arg1.class" do
      let(:lazy_object) { arg1.class }
      let(:call_args) { [1] }
      it { is_expected.to eq Integer }
    end

    context "arg1.class" do
      let(:lazy_object) { arg1.hash }
      subject { lazy_object }
      it { is_expected.not_to be_kind_of TestLazyObject }
    end

    context "arg1.hogehoge" do
      let(:lazy_object) { arg1.hogehoge }
      subject { lazy_object }
      it { is_expected.to be_kind_of TestLazyObject }
    end

    context "multiple calls" do
      let(:lazy_object) { arg1 + arg1 }
      subject { lazy_object.call(2); lazy_object.call(3) }
      it { is_expected.to eq 6 }
    end
  end

  context "#==" do
    let(:lazy_object) { Iolite::Lazy.new { |*| 42 } }
    subject { lazy_object == 42 }
    it { is_expected.to be_kind_of Iolite::Lazy }
  end

  context "#!=" do
    let(:lazy_object) { Iolite::Lazy.new { |*| 42 } }
    subject { lazy_object == 42 }
    it { is_expected.to be_kind_of Iolite::Lazy }
  end

  context "#!" do
    let(:lazy_object) { Iolite::Lazy.new { |*| 42 } }
    subject { lazy_object == 42 }
    it { is_expected.to be_kind_of Iolite::Lazy }
  end
end
