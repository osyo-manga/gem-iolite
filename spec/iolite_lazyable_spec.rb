# frozen_string_literal: true

RSpec.describe Iolite::Lazyable do
  describe "#to_lazy" do
    class TestLazyableObject
      include Iolite::Lazyable
    end

    let(:lazy_object) { TestLazyableObject.new }
    subject { lazy_object.to_lazy }

    it { is_expected.to be_kind_of Iolite::Lazy }
    it { is_expected.to have_attributes(call: lazy_object) }
  end
end
