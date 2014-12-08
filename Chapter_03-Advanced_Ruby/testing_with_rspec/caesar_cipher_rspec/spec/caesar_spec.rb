require 'spec_helper'
require 'caesar'

describe "caesar_cipher" do 
	it "shifts by a given number" do 
		caesar_cipher("hello", 5).should == "mjqqt"
	end

	it "shifts by a number larger than 26" do 
		caesar_cipher("hello", 27).should == "ifmmp"
	end

	it "properly shifts by zero" do 
		caesar_cipher("don't shift me!", 0).should == "don't shift me!"
	end

	it "properly wraps past z" do 
		caesar_cipher("Boyz are zoo animals", 20).should == "Vist uly tii uhcgufm"
	end

	it "properly keeps spaces" do 
		caesar_cipher("hello world", 10).should == "rovvy gybvn"
	end

	it "retains punctuation" do 
		caesar_cipher("hi, nice to meet you!", 15).should == "wx, cxrt id btti ndj!"
	end

	it "retains capitalization" do 
		caesar_cipher("My name's Kate", 7).should == "Tf uhtl'z Rhal"
	end

end