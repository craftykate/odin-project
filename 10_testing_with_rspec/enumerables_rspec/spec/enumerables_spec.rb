require 'spec_helper'
require 'enumerables.rb'

describe Enumerable do 
	describe "#my_each" do 
		it "should step through array and do block" do 
			arr = [1,4,7,9]
			answer = []
			arr.my_each { |item| answer << item + 2 }
			answer.should == [3,6,9,11]
		end
	end	

	describe "#my_each_with_index" do 
		it "should step through array and do block with index" do 
			arr = [5,6,7,8]
			answer = []
			arr.my_each_with_index { |item, i| answer << [item, i] }
			answer.should == [[5,0], [6,1], [7,2], [8,3]]
		end
	end

	describe "#my_select" do 
		it "should select the right items from an array based on block" do 
			arr = ["banana", 4, 10, 1, nil]
			answer = []
			arr.my_select { |item| answer << item if item.is_a?(Fixnum) && item < 5 }
			answer.should == [4,1]
		end
	end

	describe "#my_all?" do 
		context "when all in array does not satisfy block" do
			it "should return false" do 
				arr = [1,5,3,8,9]
				arr.my_all? { |item| item <= 5 }.should == false
			end
		end

		context "when no block is given" do 
			it "should return true when no items are nil or false" do 
				arr = [1,2,3,4,5]
				arr.my_all?.should == true
			end

			it "should return false when an item is nil" do 
				arr = [1,2,nil,4,5]
				arr.my_all?.should == false
			end
			
			it "should return false when an item is false" do 
				arr = [1,2,false,4,5]
				arr.my_all?.should == false
			end
		end

		context "when all in array does satisfy block" do 
			it "should return true" do 
				arr = ["boat", "car", "0", "plane"]
				arr.my_all? { |item| item.is_a?(String) }.should == true
			end
		end
	end

	describe "#my_any?" do 
		context "when no block is given" do 
			it "should return true if at least one item is not nil or false" do 
				arr = [1,2,nil,false,6]
				arr.my_any?.should == true
			end

			it "should return false if all items are nil or false" do 
				arr = [false, nil]
				arr.my_any?.should == false
			end

			it "should return false if array is empty" do 
				arr = []
				arr.my_any?.should == false
			end
		end

		context "when block is given" do 
			it "should return true when at least one item satisfies block" do 
				arr = [1,3,6,9]
				arr.my_any? { |item| item < 5 }.should == true
			end

			it "should return false when no items in array satisfies block" do 
				arr = [1,2,3,4,5]
				arr.my_any? { |item| item > 5 }.should == false
			end
		end
	end

	describe "#my_none?" do 
		context "when no block is given" do 
			it "should return true when all items are false or nil" do 
				arr = [false, nil]
				arr.my_none?.should == true
			end

			it "should return false when at least one item is not false or nil" do 
				arr = [false, "banana", nil]
				arr.my_none?.should == false
			end
		end

		context "when a block is given" do 
			it "should return true when no items satisfy block" do 
				arr = [1,2,3,4,5]
				arr.my_none? { |item| item > 5 }.should == true
			end

			it "should return false when at least one item satisfies block" do 
				arr = [1,2,3,4,5]
				arr.my_none? { |item| item >= 5 }.should == false
			end
		end
	end

	describe "#my_count" do 
		context "if no block or argument is given" do 
			it "should return the number of items, even false and nil" do 
				arr = [false, nil, 4, "banana"]
				arr.my_count.should == 4
			end

			it "should return 0 if given an empty array" do 
				arr = []
				arr.my_count.should == 0
			end
		end

		context "if a block is given" do 
			it "should return number of items that satisfy block" do 
				arr = [1,2,3,4,5]
				arr.count { |item| item % 2 == 0 }.should == 2
			end
		end

		context "if an argument is given" do 
			it "should return number of items equal to argument" do 
				arr = [1,2,3,4,2,3,4,5,1,2]
				arr.count(2).should == 3
			end
		end
	end

	describe "#my_map" do 
		context "when a block is given" do 
			it "should step through each item in array and do block" do
				arr = [1,2,3,4,5]
				arr.my_map { |item| item * 2 }.should == [2,4,6,8,10]
			end
		end

		context "when a proc is given" do 
			it "should step through each item in array and do proc" do 
				arr = [1,2,3,4,5]
				my_proc = Proc.new { |x| x + 3 }
				arr.my_map(&my_proc).should == [4,5,6,7,8]
			end
		end
	end

	describe "my_inject" do 
		context "when no argument is given, just a block" do
			it "should send each item to the block and return result" do 
				arr = [1,3,5,7]
				arr.my_inject { |sum, num| sum + num }.should == 16
			end
		end

		context "when an argument and a block is given" do 
			it "should send each item to the block, using the argument to start" do 
				arr = [1,2,3,4]
				arr.my_inject(2) { |product, num| product * num }.should == 48
			end
		end
	end

	describe "#multiply_els" do 
		it "should multiply all numbers in array" do 
			arr = [1,2,3,4]
			arr.multiply_els.should == 24
		end

		it "should properly multiply numbers when array includes 0" do 
			arr = [3,1,5,0,6]
			arr.multiply_els.should == 0
		end
	end
end