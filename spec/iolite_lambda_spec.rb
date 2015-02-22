load 'spec_helper.rb'
require "iolite/lambda"


describe "Iolite Lambda" do
	describe "Iolite::Lambda" do
		include Iolite
		arg1 = Iolite.lambda { |*args| args[0] }
		arg2 = Iolite.lambda { |*args| args[1] }

		describe "#class" do
			it "#class by Obejct#class" do
				expect(lambda { |a, b| a + b }.class).to eq(Iolite::Lambda)
			end
		end

		describe "#call" do
			it "call" do
				expect(lambda { |a, b| a + b }.call(1, 2)).to eq(3)
			end
		end

		describe "#bind" do
			it "bind argument" do
				expect(lambda { |a, b| a + b }.bind(1, 2).call()).to eq(3)
			end
			it "bind placeholders" do
				expect(lambda { |a, b| a + b }.bind(arg2, 2).call(2, 1)).to eq(3)
			end
			it "bind by placeholders" do
				expect((arg1 - arg2).bind(arg2, 2).call(1, 1)).to eq(-1)
			end
		end

		describe "#send" do
			it "send method" do
				expect(arg1.send(:length).call("homu")).to eq(4)
			end
			it "send Object method" do
				expect(arg1.send(:class).call("homu")).to eq(String)
			end
		end

		describe "#method_missing" do
			it "send method" do
				expect(arg1.length.call("homu")).to eq(4)
			end
			it "send Object method" do
				expect(arg1.class).to eq(arg1.__send__(:class))
			end
		end

		describe "#apply" do
			it "apply lambda" do
				expect(arg1.apply(1, 2).call(arg1 + arg2)).to eq(3)
			end
		end

		describe "#+" do
			it "call lambda" do
				expect((lambda { |a, b| a + b } + 3).call(1, 2)).to eq(6)
			end
		end

		describe "#==" do
			it "call" do
				expect((arg1 == 3).call(3)).to eq(true)
			end
		end
	end
end
