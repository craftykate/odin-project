class Temperature

	# Assign whatever hash was passed in to the appropriate variable
  def initialize(options)
  	@f = options[:f]
  	@c = options[:c]
  end

  # If fahrenheit was present, just display given value
  # Or else compute celsius to fahrenheit
  def in_fahrenheit
  	@f ? @f : @c * 9.0 / 5.0 + 32
  end

  # If celsius was present, just display given value
  # Or else compute fahrenheit to celsius
  def in_celsius
  	@c ? @c : (@f - 32) * 5.0 / 9.0
  end

  # Method defined on the class
  def self.from_celsius(temp)
  	self.new(c: temp)
  end

  # Method defined on the class
  def self.from_fahrenheit(temp)
  	self.new(f: temp)
  end

end

# Create new classes inheriting from Temperature. 
# When converting to fahrenheit or celsius they just call on their parent (Temperature) to supply the method to them.
class Celsius < Temperature

	def initialize(temp)
		@c = temp
	end

	def in_celsius
		super
	end

	def in_fahrenheit
		super
	end

end

class Fahrenheit < Temperature

	def initialize(temp)
		@f = temp
	end

	def in_celsius
		super
	end

	def in_fahrenheit
		super
	end
	
end