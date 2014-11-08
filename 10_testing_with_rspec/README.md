# Testing with RSpec

Project source: http://www.theodinproject.com/ruby-programming/testing-ruby

## Caesar Cipher with RSpec

[caesar_cipher_rspec](https://github.com/craftykate/odin-project/tree/master/10_testing_with_rspec/caesar_cipher_rspec)

Go back to the Building Blocks Project and write tests for your "Caesar's Cipher" code. It shouldn't take more than a half-dozen tests to cover all the possible cases.

## Enumerables with RSpec

[enumerables_rspec](https://github.com/craftykate/odin-project/tree/master/10_testing_with_rspec/enumerables_rspec)

Go back to the Advanced Building Blocks Project and write tests for any 6 of the enumerable methods you wrote there. In this case, identify several possible inputs for each of those functions and test to make sure that your implementation of them actually makes the tests pass. Be sure to try and cover some of the odd edge cases where you can.

## Tic Tac Toe with RSpec

[tictactoe_rspec](https://github.com/craftykate/odin-project/tree/master/10_testing_with_rspec/tictactoe_rspec)

Write tests for your Tic Tac Toe project. In this situation, it's not quite as simple as just coming up with inputs and making sure the method returns the correct thing. You'll need to make the tests determine victory or loss conditions are correctly assessed.

1. Start by writing tests to make sure a player wins when he or she should, e.g. when the board reads X X X across the top row, your #game-over method (or its equivalent) should be triggered.
2. Test each of your critical methods to make sure they function properly and handle edge cases.
3. Try using mocks/doubles to isolate methods and make sure that they're sending you back the right outputs.