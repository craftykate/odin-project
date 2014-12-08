# Recursion

Project source: http://www.theodinproject.com/ruby-programming/recursion

## Fibonacci

[fibonacci](https://github.com/craftykate/odin-project/tree/master/Chapter_03-Advanced_Ruby/ch03_recursion/fibonacci.rb)

The Fibonacci Sequence, which sums each number with the one before it, is a great example of a problem that can be solved recursively.

1. Write a method #fibs which takes a number and returns that many members of the fibonacci sequence. Use iteration for this solution.

2. Now write another method #fibs_rec which solves the same problem recursively. This can be done in just 3 lines (or 1 if you're crazy, but don't consider either of these lengths a requirement... just get it done).

## Merge Sort

[merge_sort](https://github.com/craftykate/odin-project/tree/master/Chapter_03-Advanced_Ruby/ch03_recursion/merge_sort.rb)

We spent some time early on dealing with sorting (e.g. bubble sort). Now it's time to take another look at sorting with Merge Sort, a type of sort that lends itself well to recursion and can be much faster than bubble sort on the right data sets. You'll build a method which sorts a given array but uses a "merge sort" method for doing so.

It can be a bit strange to wrap your head around, but just remember you're "dividing and conquering" the problem.

1. Build a method #merge_sort that takes in an array and returns a sorted array, using a recursive merge sort methodology.
2. Tips:
	1. Think about what the base case is and what behavior is happening again and again and can actually be delegated to someone else (e.g. that same method!).
	2. It may be helpful to check out the background videos again if you don't quite understand what should be going on.