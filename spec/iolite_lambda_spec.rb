load 'spec_helper.rb'
require "iolite/lambda"


describe "Iolite Lambda" do
	describe "Iolite::Lambda" do
		include Iolite
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
		describe "#+" do
			it "call lambda" do
				expect((lambda { |a, b| a + b } + 3).call(1, 2)).to eq(6)
			end
		end
	end
end
