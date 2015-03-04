load 'spec_helper.rb'
require "iolite"
require "iolite/adaptored/array"
require "iolite/adaptored/hash"
require "iolite/adaptored/proc"
require "iolite/adaptored/string"
require "iolite/adaptored/object_with_to_lazy"

describe "Iolite Adaptored" do
	include Iolite::Placeholders

	describe "Array" do
		it "call" do
			expect([arg1, arg1, arg1].call(1)).to eq([1, 1, 1])
		end
		it "call with value" do
			expect([arg1, 3, arg1].call(1)).to eq([1, 3, 1])
		end
		it "bind" do
			expect([arg1, arg1, arg1].bind(arg2).call(1, 2)).to eq([2, 2, 2])
		end
		it "call invoke" do
			expect(Iolite::Functinal.invoke([arg1, arg1, arg1], 1)).to eq([1, 1, 1])
		end
		it "nest" do
			expect([arg1, [arg2, arg3]].call(1, 2, 3)).to eq([1, [2, 3]])
		end
		it "nest binding" do
			expect([arg1, [arg1, arg2].bind(arg3, arg2)].call(1, 2, 3)).to eq([1, [3, 2]])
		end
	end

	describe "Hash" do
		it "call" do
			expect({ arg1 => arg2 }.call(:name, :homu)).to eq({ name: :homu })
		end
		it "call key" do
			expect({ arg1 => :mami }.call(:name, :homu)).to eq({ name: :mami })
		end
		it "call value" do
			expect({ :mami => arg1 }.call(:name, :homu)).to eq({ mami: :name })
		end
		it "calls" do
			expect({ arg1 => arg2, arg1 => arg3 }.call(:name, :homu, :mado)).to eq({ name: :homu, name: :mado })
		end
		it "bind" do
			expect({ arg1 => arg3, arg2 => arg4 }.bind(arg1, arg1, arg2, arg3).call(:name, :homu, :mado)).to eq({ name: :homu, name: :mado })
		end
	end

	describe "Proc" do
		describe "operator" do
			it "proc" do
				expect((proc { 10 } + 20).call()).to eq(30)
			end
			it "lambda" do
				expect((lambda { 10 } + 20).call()).to eq(30)
			end
		end
		describe "bind" do
			it "proc" do
				expect(proc { |a, b| a + b }.bind(arg1, 2).call(1)).to eq(3)
			end
			it "lambda" do
				expect(proc { |a, b| a - b }.bind(2, arg1).call(1)).to eq(1)
			end
		end
		describe "Symbol" do
			it "#to_proc" do
				expect((arg1.to_s + :to_s.to_proc).call(42)).to eq("4242")
			end
		end
	end

	describe "String" do
		it "call" do
			expect("value:#{arg1}:#{arg2}".call(1, 2)).to eq("value:1:2")
		end
		it "#to_call_by_eval" do
			expect('value:#{ Iolite::Placeholders.arg1 }:#{ Iolite::Placeholders.arg2 }'.to_call_by_eval.call(1, 2)).to eq("value:1:2")
		end
		it "#to_call_by_eval binding" do
			var = 10
			expect('value:#{ arg1 + arg2 * var }:#{ arg2 - arg1 }'.to_call_by_eval(binding).call(1, 2)).to eq("value:21:1")
		end
	end

	describe "Object" do
		describe "#to_lazy" do
			it "lazy" do
				expect(1.to_lazy.call()).to eq(1)
			end
			it "operator" do
				expect((1.to_lazy + 2).call()).to eq(3)
			end
			it "operator with placeholder" do
				expect((1.to_lazy + arg1).call(2)).to eq(3)
			end
			it "call method" do
				expect(((1..10).to_lazy.first arg1).call(3)).to eq([1, 2, 3])
			end
		end
	end
end

