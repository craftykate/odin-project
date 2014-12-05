$(document).ready(function() {
	// Initially set variables
	// squareSize is how many squares per row
	var squareSize = 32;
	// etchWidth is the width of the outer div
	var etchWidth = 417;
	// width is the size of each square
	var width = (etchWidth - 1) / squareSize;

	// Create the grid
	createEtch(squareSize, width);

	// Generate first random color
	var color1 = Math.floor(Math.random() * 256);
	var color2 = Math.floor(Math.random() * 256);
	var color3 = Math.floor(Math.random() * 256);
	// Set title to a random color 
	$("h1").css("color", "rgb("+color1+","+color2+","+color3+")");
	$("#instructions > p").css("color", "rgb("+color1+","+color2+","+color3+")");

	// Generate next random color when mouse leaves etch board
	$("#etch").on("mouseleave", function() {
		color1 = Math.floor(Math.random() * 256);
		color2 = Math.floor(Math.random() * 256);
		color3 = Math.floor(Math.random() * 256);
		// Set title to same random color as squares
		$("h1").css("color", "rgb("+color1+","+color2+","+color3+")");
	});

	// Create the ability to change the colors
	$(".cell").on("mouseenter", function() {
			$(this).css("background-color", "rgb("+color1+","+color2+","+color3+")");
			// Every time you pass over the same square the opacity increases
			$(this).css("opacity", "+=0.2");
	});

	// When the clear button is clicked
	$("button").on("click", function() {
		// Ask how many squares wide user wants the grid to be
		var newSquareSize = prompt("How many pixels wide do you want your board to be? Default is 32", "32");
		// newWidth sets the width of the new squares 
		var newWidth = (etchWidth - 1) / newSquareSize;
		// Delete the existing container
		$("#etch").detach();
		// Create the new grid with new variables
		createEtch(newSquareSize, newWidth);

		$("#instructions > p").css("color", "rgb("+color1+","+color2+","+color3+")");

		// Generate next random color when mouse leaves etch board
		$("#etch").on("mouseleave", function() {
			color1 = Math.floor(Math.random() * 256);
			color2 = Math.floor(Math.random() * 256);
			color3 = Math.floor(Math.random() * 256);
			$("h1").css("color", "rgb("+color1+","+color2+","+color3+")");
		});

		// Add back the ability to change the colors
		$(".cell").hover(function() {
			$(this).css("background-color", "rgb("+color1+","+color2+","+color3+")");
			$(this).css("opacity", "+=0.2");
		});
	});
});

// Creates the rows
function createEtch(squares, width) {
	// Create the etch div to hold the squares
	$("#instructions").before($("<div id='etch'></div>"));
	// Shorten it a little to remove white space
	$("#etch").width(417);
	$("#etch").height(417);
	// Create the rows
	for (j = 0; j < squares; j++) {
		$("#etch").append($("<div class='row' style='height: "+width+"px'>"));
		createSquares(squares, width);
		$("#etch").append($("</div>"));
	}
}

// Creates the squares
function createSquares(squares, width) {
	for (i = 0; i < squares; i++) {
		$("#etch").find(".row").last().append($("<div class='cell' style='width: "+width+"px; height: "+width+"px;'></div>"));
	}
}