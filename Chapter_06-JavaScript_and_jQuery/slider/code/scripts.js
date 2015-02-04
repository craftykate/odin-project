// SLIDER
var slider = function() {

	// Set time delay of slider
	var delay = 5000;

	// Set variables
	var numImages = $('.img').length;
	var previousImage = numImages;
	var currentImage = 1;
	var nextImage = 2;
	var previewHover = false;

	// Find width of container div
	var sliderWidth = $("#slider").width() + 2;

	// Give images same width as slider
	var sizeImages = function() {
		$("img").width(sliderWidth);
	};
	sizeImages();

	// Create as many navigation dots as there are pictures
	for (var i = 1; i <= numImages; i++) {
		$('#dots').find('ul').append($('<li class="dot ' + i + '""></li>'));
	}

	// Set initial position of images
	var resetImages = function() {
		$('.img').css({"left": sliderWidth+"px"});
		$('.img').first().css({"left": "0px"});
		$('.1').addClass("active");
	};
	resetImages();

	// Slide to next image
	var slideNextImageLeft = function() {
		$('.image-' + nextImage).css({"left": sliderWidth+"px"});
		$('.image-' + currentImage).animate({left: sliderWidth * -1}, 1000);
		$('.image-' + nextImage).animate({left: "0px"}, 1000);
		currentImage = nextImage;
		increaseImages();
	};

	// Slide to the previous image
	var slidePreviousImageRight = function() {
		$('.image-' + previousImage).css({"left": (sliderWidth * -1)+"px"});
		$('.image-' + currentImage).animate({left: sliderWidth}, 1000);
		$('.image-' + previousImage).animate({left: "0px"}, 1000);
		currentImage = previousImage;
		increaseImages();
	};

	// Shift which images are next and previous
	var increaseImages = function() {
		if(currentImage === numImages) {
			nextImage = 1;
			previousImage = currentImage - 1;
		} else {
			nextImage = currentImage + 1;
			if(currentImage === 1) {
				previousImage = numImages;
			} else {
				previousImage = currentImage - 1;
			}
		}
		// Change dots status
		$('#dots').find('li').removeClass("active");
		$('#dots').find('.' + currentImage).addClass("active");
		// If hovering over preview buttons, change picture in preview
		if(previewHover !== false) {
			showPreview();
		}
	};

	// Set initial slider interval
	moveImages = setInterval(function() {
		slideNextImageLeft();
	}, delay);

	// When next button is clicked
	$('.next').click(function() {
		clearInterval(moveImages);
		moveImages = setInterval(function() {
			slideNextImageLeft();
		}, delay);
		slideNextImageLeft();
	});

	// When previous button is clicked
	$('.previous').click(function() {
		clearInterval(moveImages);
		moveImages = setInterval(function() {
			slideNextImageLeft();
		}, delay);
		slidePreviousImageRight();
	});

	// When a navigation dot is clicked
	$('.dot').click(function() {
		buttonPressed = $('li').index(this) + 1;
		if(buttonPressed !== currentImage) {
			clearInterval(moveImages);
			moveImages = setInterval(function() {
				slideNextImageLeft();
			}, delay);
			if(currentImage < buttonPressed) {
				nextImage = buttonPressed;
				slideNextImageLeft();
			} else {
				previousImage = buttonPressed;
				slidePreviousImageRight();
			}
		}
	});

	// Show a preview of next or previous image on hover
	$('.nav').on('mouseenter', function() {
		previewHover = $('.nav').index(this) + 1;
		showPreview();
	}).on('mouseleave', function() {
		previewHover = false;
		$(".preview").css({"background-image": "none"});
	});

	var showPreview = function() {
		var whichSide = previewHover;
		var miniWidth = 100;
		var whichImage;
		if(whichSide === 1) {
			whichImage = previousImage;
		} else {
			whichImage = nextImage;
		}
		var previewImage = $('.image-' + whichImage).find('img').attr("src");
		$(".preview:nth-child(" + whichSide + ")").css({"background-image": "url(" + previewImage + ")", "background-size": "cover"});
	};
};

$(document).ready(function() {

	slider();

});