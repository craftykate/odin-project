var snakeGame = {
	settings: {
		width: 40,
		height: 40,
		foodPosition: [],
		score: 0,
		level: 1,
		foodEaten: 0,
		timing: 150,
		scores: []
	},

	snake: {
		direction: [1,0],
		length: 1,
		body: [[20,20]],
		head: function() {return this.body[0];}
	},

	init: function() {
		$('#score').find('.score').text(this.settings.score);
		$('#score').find('.level').text(this.settings.level);
		this.createBoard();
		this.generateFood();
		this.startSnake();
		this.playGame();
	},

	createBoard: function() {
		for (var row = 0; row < this.settings.width; row++) {
			$('#board').append($("<div class='row'>"));
			for (var column = 0; column < this.settings.width; column++) {
				$cell = $("<div class='cell'></div>");
				$cell.attr('data-position', [column, row]);
				$("#board").find(".row").last().append($cell);
			}
			$("#board").append($("</div>"));
		}
	},

	updateScore: function() {
		this.settings.foodEaten += 1;
		this.settings.score += this.settings.level * 1;
		if(this.settings.foodEaten % 5 === 0) {
			this.settings.level += 1;
			this.settings.timing *= 0.8;
		}
		$('#score').find('.level').text(this.settings.level);
		$('#score').find('.score').text(this.settings.score);
		$('#score').find('.food').text(this.settings.foodEaten);
	},

	generateFood: function() {
		var x = Math.floor(Math.random() * 40);
		var y = Math.floor(Math.random() * 40);
		$cell = this.findPostion(x, y);
		$cell.addClass("food");
		this.settings.foodPosition = [x, y];
	},

	startSnake: function() {
		var snakeHead = this.snake.head();
		$head = this.findPostion(snakeHead[0], snakeHead[1]);
		$head.addClass("snake-head");
	},

	playGame: function() {
		setTimeout(function() {
			snakeGame.moveSnake();
			var checkedMove = snakeGame.checkPosition();
			var response;
			if(checkedMove === 1) {
				if(snakeGame.checkIfFood()) {
					snakeGame.ateFood();
					snakeGame.playGame();
				} else {
					snakeGame.playGame();
				}
			} else {
				if(checkedMove === 2) {
					response = window.confirm('You went off the board! Press OK to play again.');
				} else if(checkedMove === 3) {
					response = window.confirm('You ate yourself! Press OK to play again.');
				}
				snakeGame.goAgain(response);
			}
		}, this.settings.timing);
	},

	moveSnake: function() {
		var snake = this.snake;
		var x = snake.body[0][0];
		var y = snake.body[0][1];
		snake.body.unshift([x + snake.direction[0], y + snake.direction[1]]);
		snake.body.pop();
		$('.cell').removeClass("snake");
		for (var i = 0; i < snake.body.length; i++) {
			this.findPostion(snake.body[i][0], snake.body[i][1]).addClass("snake");
		}
	},

	changeDirection: function(key) {
		switch (key) {
			case 37:
			this.snake.direction = [-1, 0];
			break;
			case 38:
			this.snake.direction = [0, -1];
			break;
			case 39:
			this.snake.direction = [1, 0];
			break;
			case 40:
			this.snake.direction = [0, 1];
			break;
		}
	},

	checkPosition: function() {
		var snakex = this.snake.body[0][0];
		var snakey = this.snake.body[0][1];
		if(snakex > 39 || snakex < 0 || snakey > 39 || snakey < 0) {
			return 2;
		} else {
			if(this.checkIfAteItself()) {
				return 3;
			} else {
				return 1;
			}
		}
	},

	checkIfAteItself: function() {
		var snakeHead = [this.snake.body[0][0], this.snake.body[0][1]];
		var count = 0;
		for (var i = 1; i < this.snake.body.length; i++) {
			if(this.snake.body[i][0] === snakeHead[0] && this.snake.body[i][1] === snakeHead[1]) {
				count += 1;
			}
		}
		if(count === 0) {
			return false;
		} else {
			return true;
		}
	},

	checkIfFood: function() {
		var headx = this.snake.body[0][0];
		var foodx = this.settings.foodPosition[0];
		var heady = this.snake.body[0][1];
		var foody = this.settings.foodPosition[1];
		if(headx === foodx && heady === foody)	{
			return true;
		} else {
			return false;
		}
	},

	ateFood: function() {
		this.updateScore();
		var headx = this.snake.body[0][0] + this.snake.direction[0];
		var heady = this.snake.body[0][1] + this.snake.direction[1];
		this.snake.body.unshift([headx, heady]);
		this.findPostion(headx, heady).addClass("snake");
		$('.cell').removeClass("food");
		this.generateFood();
	},

	findPostion: function(x, y) {
		return $(".row").find('[data-position="' + x + ',' + y + '"]');
	},

	displayScores: function() {
		var highScores = this.settings.scores;
		highScores.push(this.settings.score);
		highScores.sort(function(a, b) {return b-a;});
		var highScoresDiv = $('#high-scores').find('p');
		highScoresDiv.html("");
		var thisScore;
		for (var i = 0; i < 10; i++) {
			if(highScores[i] === undefined) {
				thisScore = "";
			} else {
				thisScore = highScores[i];
			}
			highScoresDiv.append(i + 1 + ". " + thisScore +
				"<br>");
		}
	},

	goAgain: function(response) {
		if(response === true) {
			this.displayScores();
			this.settings.foodPosition = [];
			this.settings.score = 0;
			this.settings.level = 1;
			this.settings.foodEaten = 0;
			this.settings.timing = 150;
			this.snake.direction = [1,0];
			this.snake.length = 1;
			this.snake.body = [[20,20]];
			$('#score').find('.score').text(this.settings.score);
			$('#score').find('.level').text(this.settings.level);
			$('.cell').removeClass("food");
			this.generateFood();
			this.startSnake();
			this.playGame();
		} else {
			this.displayScores();
		}
	}
};

$(document).ready(function() {

	snakeGame.init();

	$(document).on('keydown', function(event) {
		var key = event.which;
		event.preventDefault();
		snakeGame.changeDirection(key);
	});

});