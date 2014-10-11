# Converts fahrenheit to celcius
# This is done by subtracting 32, multiplying by 5, then dividing by 9
def ftoc(temp)
	(temp - 32) * 5.0 / 9.0
end

# Converts celcius to fahrenheit
# This is done by multiplying by 9, dividing by 5, then adding 32
def ctof(temp)
	temp * 9.0 / 5.0 + 32
end

# Note: Floats are used to multiply/divide so answers are accurate. Multiplying/dividing an integer with an integer will give an integer response. Which is not accurate!