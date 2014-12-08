// The prime factors of 13195 are 5, 7, 13 and 29.

// What is the largest prime factor of a number up to 1,000?

// Function to check if given number is prime
function isPrime(num) {
	result = true;
	for (i = 2; i < num; i++) {
		if (num % i === 0) {
			result = false;
		}
	}
	return result;
}

// Get the largest Prime Factor of a number
function getLargestPrimeFactor(num) {
	// The first number we should check is half the main number because no number bigger than that will be a factor of the number. This will cut some time off our program for larger numbers
	// We're also going down instead of up, so we can stop at the first number we find, since that will obviously be the largest
	i = num/2;
	// Run program until we get a number
	while (true) {
		// If the number is prime and is a factor of the original number...
		if (isPrime(i) && num % i === 0) {
			// Return the number we found
			return i;
		}
		// Number wasn't both prime and a factor so move to the next lowest number
		i--;
	}
}

// Run program and print out largest prime number for verification
console.log(getLargestPrimeFactor(13195)); // => 29