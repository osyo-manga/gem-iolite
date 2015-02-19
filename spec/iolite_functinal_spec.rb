load 'spec_helper.rb'
require "iolite/functinal"


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

	class First
		def iolite_functinal_invoke_call *args
			args[0]
		end
		def call *args
			args[0]
		end
	end

	describe ".invoke" do
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

	describe ".invoke_a" do
		it "callable" do
			expect(invoke_a([Callable.new, Callable.new], 1, 2)).to eq([3, 3])
		end
		it "uncallable" do
			expect(invoke_a([1, 2], 1)).to eq([1, 2])
		end
	end

	describe ".send" do
		it "send callable" do
			expect(send(4, :+, Callable.new).call(1, 2)).to eq(7)
		end
		it "send callable" do
			expect(send(Callable.new, :+, Callable.new).call(1, 2)).to eq(6)
		end
	end

	describe ".bind" do
		it "bind callable" do
			expect(bind(-> a, b { a + b }, 1, First.new).call(1, 2)).to eq(2)
		end
		it "bind method" do
			expect(bind(:+.to_proc, 1, First.new).call(2)).to eq(3)
		end
		it "bind next" do
			expect(bind(-> a, b { a + b }, bind(-> a, b { a + b }, First.new, First.new), First.new).call(3)).to eq(9)
		end
	end

	describe ".apply" do
		it "call first" do
			expect(apply(-> a { -> b { a + b} }, 1).call(2)).to eq(3)
		end
		it "NoMethodError" do
			expect{ apply(-> a { 10 }, 1).call(2) }.to raise_error(NoMethodError)
		end
	end
end
