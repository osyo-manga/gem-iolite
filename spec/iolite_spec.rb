require './spec_helper'
require "iolite/adaptor/array"
require "iolite/adaptor/hash"

describe Iolite do
	it 'has a version number' do
		expect(Iolite::VERSION).not_to be nil
	end

	describe "Iolite" do
		it "::lambda" do
			expect(Iolite.lambda { |a, b| a + b }.class).to eq(Iolite::Lambda::Wrapper)
		end
		it "::wrap" do
			expect((Iolite.wrap lambda { |a, b| a + b }).call(1, 2).class).to eq(Proc)
		end
	end

	describe "Iolite::Lambda::Wrapper" do
		first = Iolite::Lambda::Wrapper.new { |x| x }
		plus = Iolite::Lambda::Wrapper.new { |a, b| a + b }
		describe "#call" do
			it "call" do
				expect(first.call(10)).to eq(10)
			end

			it "()" do
				expect(first.(10)).to eq(10)
			end

			it "call multi arguments" do
				expect(first.call(10, 2)).to eq(10)
				expect(plus.call(10, 2)).to eq(12)
			end
		end

		describe "#bind" do
			include Iolite::Placeholders
			f = Iolite::Lambda::Wrapper.new { |a, b| a + b }
			it "argument" do
				expect(f.bind(-3, 1).call()).to eq(-2)
			end
			it "argument" do
				expect(f.bind(arg2, arg1).call(-1, 3)).to eq(2)
			end
			it "operator" do
				expect(Iolite::Lambda::Wrapper.new(&:+).bind(arg2, arg1).call(-1, 3)).to eq(2)
			end
		end

		describe "#send" do
			it "call method" do
				expect(first.send(:to_s).call(10).class).to eq(String)
			end
			it "call method with args" do
				expect(first.send(:+, 1).call(2)).to eq(3)
			end
			include Iolite::Placeholders
			it "call method with placeholders" do
				expect(first.send(:+, arg2).call(2, -2)).to eq(0)
			end
		end

		describe "#apply" do
			include Iolite::Placeholders
			it "call lambda" do
				expect(arg1.apply(1, 2).call(lambda { |a ,b| a + b })).to eq(3)
			end
			it "call Iolite::Lambda::Wrapper" do
				expect(arg1.apply(1, 2).call(Iolite::Lambda::Wrapper.new { |a ,b| a + b })).to eq(3)
			end
		end

		describe "operators" do
			it "a + b" do
				expect((first + first).call(1)).to eq(2)
			end
			it "a - b" do
				expect((plus - first).call(2, 3)).to eq(3)
			end
			it "a * b" do
				expect((first * first).call(2)).to eq(4)
			end
			it "a[b]" do
				expect((first[:name]).call({name: :homu})).to eq(:homu)
			end
			it "a + {value}" do
				expect((first + 3).call(4)).to eq(7)
			end
		end

		describe "#method_missing" do
			it "call #length method" do
				expect(first.length.call("homu")).to eq(4)
			end
			it "call #to_s method" do
				expect(first.to_i.call("1").class).to eq(Fixnum)
			end
			it "call Object#*" do
				# not call method_missing
				expect(first.class).to eq(Iolite::Lambda::Wrapper)
			end
			it "call Object#* from #send" do
				expect(first.send(:class).call("homu")).to eq(String)
			end
		end

		describe "Array block" do
			it "#map by" do
				expect((1..3).map &(first + 3)).to eq([4, 5, 6])
			end
			it "#inject by" do
				expect((2..4).inject &(plus)).to eq(9)
			end
		end
	end

	describe "Iolite::Placeholders" do
		include Iolite::Placeholders
		it "arg1" do
			expect(arg1.call(1, 2)).to eq(1)
		end
		it "arg1 + arg2" do
			expect((arg1 + arg2).call(1, 2)).to eq(3)
		end
		it "arg1[arg2]" do
			expect((arg1[arg2]).call([1, 2, 3], 2)).to eq(3)
		end
		it "args" do
			expect((args[arg2]).call(1, 3, 2, 4)).to eq(4)
		end
		it "bind" do
			# expect(arg1.bind(10).call(Iolite.lambda { |x| x + x})).to eq(20)
		end
		it "alias _1, arg1" do
			expect((_1 + _2).call(1, 2)).to eq(3)
		end
	end

	describe "Iolite::adaptor" do
		describe "Adapt callable" do
			include Iolite::Placeholders
			class UnCallableFromIolite
			end
			it "not callable" do
				# UnCallableFromIolite.new.class
				expect(arg1.send(:class).bind(UnCallableFromIolite.new).call(10)).to eq(UnCallableFromIolite)
			end
			class CallableFromIolite
				iolite_adaptor_callable
				def call n
					n
				end
			end
			it "callable" do
				# CallableFromIolite.new.call("homu")
				expect(arg1.send(:class).bind(CallableFromIolite.new).call("homu")).to eq(String)
			end
			it "wrap" do
				expect(arg1.send(:class).bind(Iolite.wrap CallableFromIolite.new).call("homu")).to eq(CallableFromIolite)
			end
		end
		describe "Adapt Array" do
			include Iolite::Placeholders
			it "apply argument" do
				expect([arg1, arg2, 10].to_proc.call(1, 2)).to eq([1, 2, 10])
			end
		end
		describe "Adapt Hash" do
			include Iolite::Placeholders
			it "apply argument" do
				expect({ arg1 => arg2 }.to_proc.call(:name, "homu")).to eq({name: "homu"})
			end
		end
	end

	describe "Iolite::Statement" do
		describe "if_else" do
			include Iolite::Statement
			include Iolite::Placeholders
			it "call then" do
				f = if_else(arg1 > 0, arg2, nil)
				expect(f.(10, "yes")).to eq("yes")
			end
			it "call else" do
				f = if_else(arg1 > 0, arg2, nil)
				expect(f.(-10, "yes")).to eq(nil)
			end
		end
		describe "if_" do
			describe "if then" do
				include Iolite::Statement
				include Iolite::Placeholders
				it "call then" do
					f = if_(arg1 > 0)[ arg1, arg1 + arg1 ]
					expect(f.(10)).to eq(20)
				end
				it "call else" do
					f = if_(arg1 > 0)[ arg1, arg1 + arg1 ]
					expect(f.(0)).to eq(nil)
				end
			end
			describe "if then else" do
				include Iolite::Statement
				include Iolite::Placeholders
				it "call then" do
					f = if_(arg1 > 0)[ arg1, arg1 + arg1 ].else_[ arg1, arg1 - arg1 ]
					expect(f.(10)).to eq(20)
				end
				it "call else" do
					f = if_(arg1 > 0)[ arg1, arg1 + arg1 ].else_[ arg1, arg1 - arg1 ]
					expect(f.(-10)).to eq(0)
				end
			end
		end
	end
end
