# Testing with RSpec

Project source: http://www.theodinproject.com/ruby-programming/testing-ruby

## Caesar Cipher with RSpec

[caesar_cipher_rspec](https://github.com/craftykate/odin-project/tree/master/Chapter_03-Advanced_Ruby/ch03_testing_with_rspec/caesar_cipher_rspec)

Go back to the Building Blocks Project and write tests for your "Caesar's Cipher" code. It shouldn't take more than a half-dozen tests to cover all the possible cases.

## Enumerables with RSpec

[enumerables_rspec](https://github.com/craftykate/odin-project/tree/master/Chapter_03-Advanced_Ruby/ch03_testing_with_rspec/enumerables_rspec)

Go back to the Advanced Building Blocks Project and write tests for any 6 of the enumerable methods you wrote there. In this case, identify several possible inputs for each of those functions and test to make sure that your implementation of them actually makes the tests pass. Be sure to try and cover some of the odd edge cases where you can.

## Tic Tac Toe with RSpec

[tictactoe_rspec](https://github.com/craftykate/odin-project/tree/master/Chapter_03-Advanced_Ruby/ch03_testing_with_rspec/tictactoe_rspec)

Write tests for your Tic Tac Toe project. In this situation, it's not quite as simple as just coming up with inputs and making sure the method returns the correct thing. You'll need to make the tests determine victory or loss conditions are correctly assessed.

1. Start by writing tests to make sure a player wins when he or she should, e.g. when the board reads X X X across the top row, your #game-over method (or its equivalent) should be triggered.
2. Test each of your critical methods to make sure they function properly and handle edge cases.
3. Try using mocks/doubles to isolate methods and make sure that they're sending you back the right outputs.

## Connect Four with RSpec

[connect_four_rspec](https://github.com/craftykate/odin-project/tree/master/Chapter_03-Advanced_Ruby/ch03_testing_with_rspec/connect_four_rspec)

Build Connect Four! Just be sure to keep it TDD.

Only write exactly enough code to make your test pass. Oftentimes, you'll end up having to write two tests in order to make a method do anything useful. That's okay here. It may feel a bit like overkill, but that's the point of the exercise. Your thoughts will probably be something like "Okay, I need to make this thing happen. How do I test it? Okay, wrote the test, how do I code it into Ruby? Okay, wrote the Ruby, how can I make this better?" You'll find yourself spending a fair bit of time Googling and trying to figure out exactly how to test a particular bit of functionality. That's also okay... You're really learning RSpec here, not Ruby, and it takes some getting used to.
