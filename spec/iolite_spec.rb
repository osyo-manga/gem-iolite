# frozen_string_literal: true

RSpec.describe Iolite do
  it "has a version number" do
    expect(Iolite::VERSION).not_to be nil
  end

  describe "include Iolite" do
    let(:object) {
      Class.new {
        include Iolite

        def subject; arg1; end
      }.new
    }
    subject { object.public_send(call_method_name) }

    context "call #subject" do
      let(:call_method_name) { :subject }
      it { is_expected.to be_kind_of(Iolite::Lazy) }
    end

    context "call #arg1" do
      let(:call_method_name) { :arg1 }
      it { expect { subject }.to raise_error(NoMethodError) }
    end
  end

  describe "using Iolite" do
    using Iolite

    let(:object) {
      class TestWithUsingIolite
        def subject; arg1; end
      end
      TestWithUsingIolite.new
    }
    subject { object.public_send(call_method_name) }

    context "call #subject" do
      let(:call_method_name) { :subject }
      it { is_expected.to be_kind_of(Iolite::Lazy) }
    end

    context "call #to_lazy" do
      let(:call_method_name) { :to_lazy }
      it { is_expected.to be_kind_of(Iolite::Lazy) }
    end
  end
end
