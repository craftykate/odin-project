// If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.

// Find the sum of all the multiples of 3 or 5 below 1000.

// Declare variable to hold running sum
var sum_of_multiples = 0;
// Loop through each number between 1 and 1,000
for (var i = 1; i < 1000; i++) {
	// If it's a multiple of 3 or 5...
	if (i % 3 === 0 || i % 5 === 0) {
		// Add it to our running sum
		sum_of_multiples += i;
	}
}
// Print out sum for verification
console.log(sum_of_multiples); // => 233,168