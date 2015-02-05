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
	settings.score = 0;
	settings.level = 1;
	settings.foodEaten = 0;
	settings.timing = 150;
	settings.ateFood = false;
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

function checkPosition() {
	var snakex = snake.body[0][0];
	var snakey = snake.body[0][1];
	if(snakex > 39 || snakex < 0 || snakey > 39 || snakey < 0) {
		return "off";
	} else {
		if(checkIfAteItself()) {
			return "ate";
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

function updateScore() {
	settings.foodEaten += 1;
	settings.score += settings.level * 1;
	if(settings.foodEaten % 5 === 0) {
		settings.level += 1;
		settings.timing *= 0.8;
	}
	$('#scores').find('.level').text(settings.level);
	$('#scores').find('.score').text(settings.score);
}

function checkIfFood() {
	var headx = snake.body[0][0];
	var foodx = settings.foodPosition[0];
	var heady = snake.body[0][1];
	var foody = settings.foodPosition[1];
	if(headx === foodx && heady === foody)	{
		generateFood();
		updateScore();
		return true;
	} else {
		return false;
	}
}

function compareScores(a, b) {
	if(a[0] > b[0]) {return -1;}
	if(a[0] < b[0]) {return 1;}
}

function displayScores(response) {
	var highScores = settings.scores;
	highScores.push([settings.score, response]);
	highScores.sort(compareScores);
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

function endGame(response) {
	displayScores(response);
	$('#scores').find('.score').text(settings.score);
	$('#scores').find('.level').text(settings.level);
	$('.start').show();
}

function playGame() {
	setTimeout(function() {
		moveSnake();
		var checkMove = checkPosition();
		var response;
		if(checkMove === "ok") {
			if(checkIfFood()) {
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
			}
			endGame(response);
		}
	}, settings.timing);
}

function init() {
	resetVariables();
	$('#scores').find('.score').text(settings.score);
	$('#scores').find('.level').text(settings.level);
	$('.start').hide();
	generateFood();
	playGame();
}

$(document).ready(function() {
	createBoard();
	init();

	$(document).on('keydown', function(event) {
		var key = event.which;
		event.preventDefault();
		changeDirection(key);
	});

	$('.start').find('p').click(function() {
		init();
	});
});