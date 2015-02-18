load 'spec_helper.rb'

describe "Iolite::Functinal" do
	include Iolite::Functinal
	class Callable
			def iolite_functinal_invoke_call a, b
				a + b
			end
	end
	class Uncallable
		def call x
			x + x
		end
	end
	describe "invoke" do
		it "callable" do
			expect(invoke(Callable.new, 1, 2)).to eq(3)
		end
		it "uncallable" do
			expect(invoke(3, 1)).to eq(3)
		end
		it "uncallable call" do
			expect(invoke(Uncallable.new, 1).class).to eq(Uncallable)
		end
		it "uncallable proc" do
			expect(invoke(proc { |a, b| a + b }, 1, 2).class).to eq(Proc)
		end
	end
	describe "invoke_a" do
		it "callable" do
			expect(invoke_a([Callable.new, Callable.new], 1, 2)).to eq([3, 3])
		end
		it "uncallable" do
			expect(invoke_a([1, 2], 1)).to eq([1, 2])
		end
	end
	describe "send" do
		it "send callable" do
			expect(send(4, :+, Callable.new).call(1, 2)).to eq(7)
		end
		it "send callable" do
			expect(send(Callable.new, :+, Callable.new).call(1, 2)).to eq(6)
		end
	end
end
