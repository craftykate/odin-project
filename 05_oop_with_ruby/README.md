# OOP with Ruby

Project Source: http://www.theodinproject.com/ruby-programming/oop

## Tic Tac Toe

[tic_tac_toe.rb](https://github.com/craftykate/odin-project/blob/master/04_advanced_building_blocks/tic_tac_toe.rb)

Build a tic-tac-toe game on the command line where two human players can play against each other and the board is displayed in between turns.

1. Think about how you would set up the different elements within the game... What should be a class? Instance variable? Method? A few minutes of thought can save you from wasting an hour of coding.

2. Build your game, taking care to not share information between classes any more than you have to.

## Mastermind

[mastermind.rb](https://github.com/craftykate/odin-project/blob/master/04_advanced_building_blocks/mastermind.rb)

Build a Mastermind game from the command line where you have 12 turns to guess the secret code, starting with you guessing the computer's random code.

1. Think about how you would set this problem up!

2. Build the game assuming the computer randomly selects the secret colors and the human player must guess them. Remember that you need to give the proper feedback on how good the guess was each turn!

3. Now refactor your code to allow the human player to choose whether she wants to be the creator of the secret code or the guesser.

4. Build it out so that the computer will guess if you decide to choose your own secret colors. Start by having the computer guess randomly (but keeping the ones that match exactly).

5. Next, add a little bit more intelligence to the computer player so that, if the computer has guessed the right color but the wrong position, its next guess will need to include that color somewhere. Feel free to make the AI even smarter.