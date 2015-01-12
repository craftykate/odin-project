$(document).ready(function() {

	// Activate "clear tape" link
	$("#tape p.clear").click(function () {
		$("#tape p.tape").html("");
	});

	// Set height of tape to height of calculator
	$("#tape").css({'height': ($(".calculator").height() + 'px')
});

	// Reset variables 
	var num1 = [],
			num2 = [],
			memnum = null,
			current = null,
			operator = null,
			result = null,
			objDiv = null;

	// When a key is pressed 
	$(".keys").click(function () {
		var input = $(this).html();

		// If it's a number 
		if ($(this).hasClass("num")) {
			$(".operator").removeClass("active");
			// If it's the first number or no number has been entered, push number to num1
			if (current === 1 || current === null) {
				num1.push(input);
				current = 1;
				$(".result").html(num1.join(''));
				removeClear();
			}
			// If it's the second number, push number to num2
			if (current === 2) {
				num2.push(input);
				current = 2;
				$(".result").html(num2.join(''));
				removeClear();
			}
			// If the last button was an operator, reset num2 and push number to num2
			if (current === 0) {
				num2 = [];
				num2.push(input);
				current = 2;
				$(".result").html(num2.join(''));
				removeClear();
			}
			// If the last button was equals, clear everything and push number to num1 to start again
			if (current === 3) {
				clear();
				num1.push(input);
				current = 1;
				$(".result").html(num1.join(''));
				removeClear();
			}
		} // end number

		// If it's an operator 
		if ($(this).hasClass("operator")) {
			$(".operator").removeClass("active");
			// If num1 has a value do stuff. If no num1 is set, the operator shouldn't do anything
			if (num1 !== null) {
				$(this).addClass("active");
				// If the last button was an operator, just assign new operator to override it
				if (current === 0) {
					operator = input;
				}
				// If the current number is num1, set operator and add num1 to tape
				if (current === 1) {
					operator = input;
					current = 0;
					$("#tape p.tape").append(num1.join(''));
					objDiv = document.getElementById("tape");
					objDiv.scrollTop = objDiv.scrollHeight;
				}
				// If the current number is num2, two numbers and an operator already exist, so calculate previous numbers, set operator, reset num2 and move on
				if (current === 2) {
					calcResult();
					operator = input;
					current = 0;
					num2 = [];
					$("#tape p.tape").append(num1.join(''));
					objDiv = document.getElementById("tape");
					objDiv.scrollTop = objDiv.scrollHeight;
				}
				// If the last button was equals, reset num2 to continue calculation
				if (current === 3) {
					operator = input;
					num2 = [];
					current = 0;
					$("#tape p.tape").append(num1.join(''));
					objDiv = document.getElementById("tape");
					objDiv.scrollTop = objDiv.scrollHeight;
				}
			}
		} // end operator

		// If it's the equals sign 
		if ($(this).hasClass("equals")) {
			// As long as there is a num1, calculate result
			if (num1 !== []) {
				calcResult();
			}
		} // end equals

		// If it's the clear button 
		if ($(this).hasClass("clear")) {
			// If it's all clear, clear everything
			if ($(this).hasClass("all")) {
				$(".operator").removeClass("active");
				clear();
				// it's just clear, not all clear so...
			} else {
				// Clear the current number and change state of clear button
				if (current === 1) {
					num1 = [];
					$(".result").html(0);
					addClear();
				}
				if (current === 2) {
					num2 = [];
					$(".result").html(0);
					addClear();
				}
				// If last button was an operator
				if (current === 0) {
					clear();
				}
			}
		} // end clear

		// If it's the plus/minus button
		if ($(this).hasClass("pm")) {
			// If current number is num1 or the equals sign (so number displayed is num1 by default) was just pressed, multiply num1 by -1
			if (current === 1 || current === 3) {
				num1 = [+num1.join('') * -1];
				$(".result").html(num1.join(''));
			}
			// If current number is num2, mult num2 by -1
			if (current === 2) {
				num2 = [+num2.join('') * -1];
				$(".result").html(num2.join(''));
			}
		} // end plus/minus

		// If it's the percent button 
		if ($(this).hasClass("percent")) {
			// Divide current number by 100
			if (current === 1 || current === 3) {
				num1 = [num1 / 100];
				$(".result").html(num1.join(''));
			}
			if (current === 2) {
				num2 = [num2 / 100];
				$(".result").html(num2.join(''));
			}
		} // end percent

		// If memory add button
		if ($(this).hasClass("madd")) {
			// If no value stored, make memnum the number on the screen, otherwise add number on screen to memnum
			memnum = (memnum === null) ? (+$(".result").text()) : memnum + (+$(".result").text());
			$(".memory").html("m = " + memnum);
		}

		// If memory subtract button
		if ($(this).hasClass("msub")) {
			// If there's a value in memnum, subtract number on screen from memnum
			if (memnum !== null) {
				memnum = memnum - (+$(".result").text());
				$(".memory").html("m = " + memnum);
			}
		}

		// If memory recall button
		if ($(this).hasClass("mrec")) {
			// As long as there's a value in memnum
			if (memnum !== null) {
				// Put memnum on screen
				$(".result").html(memnum);
				// Make current number equal memnum
				if (current === 1 || current === 3) {
					num1 = [memnum];
				}
				if (current === 2 || current === 0) {
					num2 = [memnum];
				}
			}
		}

		// If memeory clear button
		if ($(this).hasClass("mclr")) {
			// reset memnum
			memnum = null;
			$('.memory').html("");
		}
	}); // end key click

	// Change behavior of clear button 
	function removeClear() {
		$(".calculator .clear").removeClass("all");
		$(".calculator .clear").html("C");
	}

	function addClear() {
		$(".calculator .clear").addClass("all");
		$(".calculator .clear").html("AC");
	} // end clear functions

	// Calculate result 
	function calcResult() {
		var n1 = +num1.join('');
		if (operator !== null) {
			// If no value for num2, make num2 equal num1 ("3+" means 3+3)
			if (num2 !== []) {
				n2 = +num2.join('');
			} else {
				n2 = n1;
			}
			switch (operator) {
				case '+':
				result = n1 + n2;
				break;
				case '-':
				result = n1 - n2;
				break;
				case '*':
				result = n1 * n2;
				break;
				case '/':
				result = n1 / n2;
				break;
			}
			// Shorten decimals and trailing zeros
			$(".result").html(formatNum(result));
			// Add result to tape
			$("#tape p.tape").append(" " + operator + " " + n2 + "<br>= " + formatNum(result) + "<br>");
			objDiv = document.getElementById("tape");
			objDiv.scrollTop = objDiv.scrollHeight;
			// Set num1 to result
			num1 = [result];
			// Keep num2 the same, in case equals is pressed again
			num2 = [n2];
			current = 3;
			addClear();
		}
	} // end calcResult function

	// Trim extra zeros, trim too many decimals 
	function formatNum(result) {
		return (result % 1 === 0) ? result : parseFloat(result.toFixed(8));
	} // end formatNum function

	// Clear all numbers 
	function clear() {
		num1 = [];
		num2 = [];
		operator = null;
		result = null;
		current = null;
		$(".result").html(0);
		$(".operator").removeClass("active");
		$("#tape p.tape").append("<hr>");
		objDiv = document.getElementById("tape");
		objDiv.scrollTop = objDiv.scrollHeight;
		addClear();
	}
});