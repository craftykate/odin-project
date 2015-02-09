var settings = {
	width: 40,
	height: 40,
	scores: [],
	lastScore: 0
};

var snake = {
	direction: [1,0],
	body: [[19,20]]
};

function resetVariables() {
	settings.foodPosition = [];
	settings.waterPosition = [];
	settings.goldPosition = [];
	settings.bombPosition = [];
	settings.ateFood = false;
	settings.score = 0;
	settings.level = 1;
	settings.foodEaten = 0;
	settings.timing = 150;
	settings.bonusPoints = 0;
	snake.direction = [1,0];
	snake.body = [[19,20]];
}

var findPosition = function(x, y) {
	return $(".row").find('[data-position="' + x + ',' + y + '"]');
};

function createBoard() {
	for (var row = 0; row < settings.width; row++) {
		$('#board').append($("<div class='row'>"));
		for (var column = 0; column < settings.width; column++) {
			var cell = $("<div class='cell'></div>");
			cell.attr('data-position', [column, row]);
			$("#board").find(".row").last().append(cell);
		}
		$("#board").append($("</div>"));
	}
}

function drawSnake() {
	$('.cell').removeClass("snake");
	$('.cell').removeClass("snake-head");
	for (var i = 0; i < snake.body.length; i++) {
		var colorSquare = snake.body[i];
		var snakeType;
		if(i === 0) {
			snakeType = "snake-head";
		} else {
			snakeType = "snake";
		}
		findPosition(colorSquare[0], colorSquare[1]).addClass(snakeType);
	}
}

function generateFood() {
	$('.cell').removeClass("food");
	var x = Math.floor(Math.random() * 38 + 1);
	var y = Math.floor(Math.random() * 38 + 1);
	var foodPosition = findPosition(x, y);
	foodPosition.addClass("food");
	settings.foodPosition = [x, y];
}

function generateWater() {
	var x = Math.floor(Math.random() * 38 + 1);
	var y = Math.floor(Math.random() * 38 + 1);
	var waterPosition = findPosition(x, y);
	waterPosition.addClass("water");
	settings.waterPosition = [x, y];
	removeWaterFunction = setTimeout(function() {
		if($('.cell').hasClass("water")) {
			settings.bonusPoints = 0;
			updateBonus();
		}
		$('.cell').removeClass("water");
		settings.waterPosition = [];
	}, 4000);
}

function generateGold() {
	var x = Math.floor(Math.random() * 38 + 1);
	var y = Math.floor(Math.random() * 38 + 1);
	var goldPosition = findPosition(x, y);
	goldPosition.addClass("gold");
	settings.goldPosition = [x, y];
	removeGoldFunction = setTimeout(function() {
		if($('.cell').hasClass("gold")) {
			settings.bonusPoints = 0;
			updateBonus();
		}
		$('.cell').removeClass("gold");
		settings.goldPosition = [];
	}, 4000);
}

function generateBomb() {
	generateBombFunction = setInterval(function() {
		var x = Math.floor(Math.random() * 40);
		var y = Math.floor(Math.random() * 40);
		while(x === settings.foodPosition[0] && y === settings.foodPosition[1]) {
			x = Math.floor(Math.random() * 40);
			y = Math.floor(Math.random() * 40);
		}
		var bombPosition = findPosition(x, y);
		bombPosition.addClass("bomb");
		settings.bombPosition = [x, y];
		setTimeout(function() {
			$('.cell').removeClass("bomb");
			settings.bombPosition = [];
		}, 10000);
	}, 20000);
}

function moveSnake() {
	var x = snake.body[0][0];
	var y = snake.body[0][1];
	snake.body.unshift([x + snake.direction[0], y + snake.direction[1]]);
	if(settings.ateFood === false) {
		snake.body.pop();
	}
	drawSnake();
}

function checkIfAteItself() {
	var snakeHead = [snake.body[0][0], snake.body[0][1]];
	var count = 0;
	for (var i = 1; i < snake.body.length; i++) {
		if(snake.body[i][0] === snakeHead[0] && snake.body[i][1] === snakeHead[1]) {
			count += 1;
		}
	}
	if(count === 0) {
		return false;
	} else {
		return true;
	}
}

function checkIfBomb() {
	var snakeHead = [snake.body[0][0], snake.body[0][1]];
	if(snakeHead[0] === settings.bombPosition[0] && snakeHead[1] === settings.bombPosition[1]) {
		return true;
	} else {
		return false;
	}
}

function checkPosition() {
	var snakex = snake.body[0][0];
	var snakey = snake.body[0][1];
	if(snakex > 39 || snakex < 0 || snakey > 39 || snakey < 0) {
		return "off";
	} else {
		if(checkIfAteItself()) {
			return "ate";
		} else if(checkIfBomb()) {
			return "bomb";
		} else {
			return "ok";
		}
	}
}

function changeDirection(key) {
	switch (key) {
		case 37:
		snake.direction = [-1, 0];
		break;
		case 38:
		snake.direction = [0, -1];
		break;
		case 39:
		snake.direction = [1, 0];
		break;
		case 40:
		snake.direction = [0, 1];
		break;
	}
}

function updateScore(type) {
	if(type === "food") {
		settings.foodEaten += 1;
		settings.score += settings.level;
		if(settings.foodEaten % 5 === 0) {
			settings.level += 1;
			settings.timing *= 0.85;
			if(settings.foodEaten % 10 === 0) {
				generateWater();
			}
		}
		if(settings.foodEaten % 13 === 0) {
			generateGold();
		}
	} else if(type === "water") {
		settings.score += settings.level * 2;
	} else if(type === "gold") {
		settings.timing *= 1.15;
		settings.score += settings.level * 3;
	}
	$('#scores').find('.level').text(settings.level);
	$('#scores').find('.score').text(settings.score);
}

function updateBonus() {
	if(settings.bonusPoints === 4) {
		settings.bonusPoints = 0;
		var newSnakeLength = (snake.body.length / 2) - 1;
		snake.body = snake.body.slice(0, newSnakeLength);
	}
	$('#in-a-row').find('.gotit').removeClass("gotit");
	for (var i = 1; i <= settings.bonusPoints; i++) {
		$('#in-a-row').find('.' + i).addClass("gotit");
	}
}

function checkIfFood() {
	var headx = snake.body[0][0];
	var heady = snake.body[0][1];
	var foodx = settings.foodPosition[0];
	var foody = settings.foodPosition[1];
	var waterx = settings.waterPosition[0];
	var watery = settings.waterPosition[1];
	var goldx = settings.goldPosition[0];
	var goldy = settings.goldPosition[1];
	var points;
	if(headx === foodx && heady === foody)	{
		generateFood();
		updateScore("food");
		return "food";
	} else if(headx === waterx && heady === watery) {
			updateScore("water");
			$('.cell').removeClass("water");
			settings.waterPosition = [];
			points = settings.level * 2;
			$('#awards').find('p').html('<span class="water">You got water!<br/>+' + points +' points</span>');
			settings.bonusPoints += 1;
			updateBonus();
			setTimeout(function() {
				$('#awards').find('p').html("");
			}, 3000);
	} else if(headx === goldx && heady === goldy) {
			updateScore("gold");
			$('.cell').removeClass("gold");
			settings.goldPosition = [];
			points = settings.level * 3;
			$('#awards').find('p').html('<span class="gold">You got gold!<br/>+' + points +' points</span>');
			settings.bonusPoints += 1;
			updateBonus();
			setTimeout(function() {
				$('#awards').find('p').html("");
			}, 3000);
	} else {
		return false;
	}
}

function compareScores(a, b) {
	if(a[0] > b[0]) {return -1;}
	if(a[0] < b[0]) {return 1;}
}

function displayScores(response) {
	settings.scores.push([settings.score, response]);
	settings.scores.sort(compareScores);
	var highScores = settings.scores.slice(0,10);
	var highScoresDiv = $('#high-scores').find('ul');
	highScoresDiv.html("");
	var thisScore;
	for (var i = 0; i < 10; i++) {
		if(highScores[i] === undefined) {
			highScoresDiv.append("<li>" + (i + 1) + ". </li>");
		} else {
			thisScore = highScores[i];
			if(highScores[i][1] === "") {
				thisScore[1] = "Anon";
			}
			highScoresDiv.append("<li>" + (i + 1) + ". " + thisScore[1] +
			": " + thisScore[0] + "</li>");
		}
	}
}

function explodeSnake() {
	var snakeLength = snake.body.length - 1;
	$('.cell').removeClass("snake");
	for (var i = 0; i < snakeLength; i++) {
		var x = Math.floor(Math.random() * 40);
		var y = Math.floor(Math.random() * 40);
		var snakePosition = findPosition(x, y);
		snakePosition.addClass("snake");
	}
}

function endGame(response) {
	displayScores(response);
	$('#scores').find('.score').text(settings.score);
	$('#scores').find('.level').text(settings.level);
	clearInterval(generateBombFunction);
	if($('.cell').hasClass("water")) {
		clearTimeout(removeWaterFunction);
	}
	if($('.cell').hasClass("gold")) {
		clearTimeout(removeGoldFunction);
	}
	$('.start').show();
}

function playGame() {
	setTimeout(function() {
		moveSnake();
		var checkMove = checkPosition();
		var response;
		if(checkMove === "ok") {
			var foodType = checkIfFood();
			if(foodType === "food") {
				settings.ateFood = true;
			} else {
				settings.ateFood = false;
			}
			playGame();
		} else {
			if(checkMove === "off") {
				response = window.prompt('You went off the board! Your score: ' + settings.score + '. What is your name?');
			} else if(checkMove === "ate") {
				response = window.prompt('You ate yourself! Your score: ' + settings.score + '. What is your name?');
			} else if(checkMove === "bomb") {
				explodeSnake();
				response = window.prompt('You ate a bomb and exploded! Your score: ' + settings.score + '. What is your name?');
			}
			endGame(response);
		}
	}, settings.timing);
}

function init() {
	$('.cell').removeClass("water");
	$('.cell').removeClass("gold");
	$('.cell').removeClass("bomb");
	$('#in-a-row').find('td').removeClass("gotit");
	resetVariables();
	$('#scores').find('.score').text(settings.score);
	$('#scores').find('.level').text(settings.level);
	$('.start').hide();
	generateBomb();
	generateFood();
	playGame();
}

$(document).ready(function() {

	createBoard();
	$('.start').show();
	
	$(document).on('keydown', function(event) {
		var key = event.which;
		event.preventDefault();
		changeDirection(key);
	});

	$('.start').find('.button').click(function() {
		init();
	});

});