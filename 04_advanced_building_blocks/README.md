# Advanced Ruby Building Blocks

Project Source: http://www.theodinproject.com/ruby-programming/advanced-building-blocks

## Bubble Sort

[bubble_sort.rb](https://github.com/craftykate/odin-project/blob/master/04_advanced_building_blocks/bubble_sort.rb)

Build a method #bubble_sort that takes an array and returns a sorted array. It must use the bubble sort methodology (using #sort would be pretty pointless, wouldn't it?).

```ruby
> bubble_sort([4,3,78,2,0,2])
    => [0,2,2,3,4,78]
```

## Bubble Sort By

[bubble_sort_by.rb](https://github.com/craftykate/odin-project/blob/master/04_advanced_building_blocks/bubble_sort_by.rb)

Now create a similar method called #bubble_sort_by which sorts an array but accepts a block. The block should take two arguments which represent the two elements currently being compared. Expect that the block's return will be similar to the spaceship operator you learned about before -- if the result of the block is negative, the element on the left is "smaller" than the element on the right. 0 means they are equal. A positive result means the right element is greater. Use this to sort your array.

```ruby
> bubble_sort_by(["hi","hello","hey"]) do |left,right|
>   right.length - left.length
> end
	=> ["hi", "hey", "hello"]
```