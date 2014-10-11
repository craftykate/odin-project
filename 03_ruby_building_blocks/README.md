# Ruby Building Blocks

Project Source: http://www.theodinproject.com/ruby-programming/building-blocks

## Caesar Cipher

[caesar.rb](https://github.com/craftykate/odin-project/blob/master/03_ruby_building_blocks/ceasar.rb)

Implement a caesar cipher that takes in a string and the shift factor and then outputs the modified string:

```ruby
> caesar_cipher("What a string!", 5)
    => "Bmfy f xywnsl!"
```

## Stock Picker

[stocks.rb](https://github.com/craftykate/odin-project/blob/master/03_ruby_building_blocks/stocks.rb)

Implement a method #stock_picker that takes in an array of stock prices, one for each hypothetical day. It should return a pair of days representing the best day to buy and the best day to sell. Days start at 0.

```ruby
> stock_picker([17,3,6,9,15,8,6,1,10])
    => [1,4]  # for a profit of $15 - $3 == $12
```