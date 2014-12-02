class Node
	attr_accessor :position, :index, :parent, :label

	def initialize(position, i)
		# Coordinates on a chess board
		@position = position
		# Index position in the array
		@index = i
		# Label is 0 if it's the starting point, 2 if it's the ending point and 1 if the chess piece has visited it. Keeps chess pieces from traveling over the same spot. 
		@label = nil
		# Stores who its parent is, so we can retrace our steps at the end
		@parent = nil
	end

end

class FindPath

	def initialize(start, stop)
		# Create the board of coordinates
		create_board
		# A checking variable to see if we've won
		@won = 0
		# Starting coordinates
		@start = start
		# Stopping coordinates
		@stop = stop
		# Checking variables to see if starting and stopping coordinates are valid
		check_start, check_stop = 0, 0
		# Our queue of which coordinates to check next
		@queue = []
		# Find our starting and stopping positions on the board, give them the right label and increase our checking variable
		@board.each_with_index do |spot, i|
			if spot.position == @start
				@starting_position = @board[i]
				spot.label = 0
				check_start += 1
			end
			if spot.position == @stop
				spot.label = 2
				check_stop += 1
			end
		end
		# If our checking variables are 1 (meaning exactly one place on the board was found for each) start the program off with the starting position
		if check_start == 1 && check_stop == 1
			jump(@starting_position)
		elsif check_start != 1
			puts "Oops, your starting point is not on the board, pick again"
		elsif check_stop != 1
			puts "Oops, your stopping point is not on the board, pick again"
		end
	end

	def jump(parent, queue = [])
		# knight_coordinates are coordinates that the parent wants to jump to
		knight_coordinates = []
		knight_coordinates << [(parent.position[0] - 1), (parent.position[1] - 2)]
		knight_coordinates << [(parent.position[0] + 1), (parent.position[1] - 2)]
		knight_coordinates << [(parent.position[0] + 2), (parent.position[1] - 1)]
		knight_coordinates << [(parent.position[0] + 2), (parent.position[1] + 1)]
		knight_coordinates << [(parent.position[0] + 1), (parent.position[1] + 2)]
		knight_coordinates << [(parent.position[0] - 1), (parent.position[1] + 2)]
		knight_coordinates << [(parent.position[0] - 2), (parent.position[1] + 1)]
		knight_coordinates << [(parent.position[0] - 2), (parent.position[1] - 1)]
		# knight_indexes are the indexes that the parent wants to jump to
		knight_indexes = [(parent.index - 17), (parent.index - 15), (parent.index - 6), (parent.index + 10), (parent.index + 17), (parent.index + 15), (parent.index + 6), (parent.index - 10)]
		# If the two match up (index 39 == [7,4]) we know it's a valid spot to jump and not off the board
		# Step through each possible coordinate
		knight_coordinates.each do |coord|
			# If the board includes those coordinates...
			if @board_coord.include?(coord)
				# Board includes coordinates, so go through each possible index
				knight_indexes.each do |index|
					# When the possible index has the same coordinates as our possible coordinate
					if @board[index] != nil && @board[index].position == coord 
						# Check the label of the position
						# If it's 2, that's our ending spot, so we've won
						if @board[index].label == 2
							# Tell the current spot who its parent is
							@board[index].parent = parent
							# And show the winning message
							show_winner(@board[index])
							# Increase our checking variable so we don't keep going later
							@won = 1
						# If the label of the position is nil, that's an unvisited coordinate, so...
						elsif @board[index].label == nil
							# Give that position a label of 1 (so no one else tries to jump on it)
							@board[index].label = 1
							# Tell it who its parent is
							@board[index].parent = parent
							# And add it to the queue to check later
							queue << @board[index]
						end
					end
				end
			# The board doesn't include those coordinates, so it's off the board. Delete the coordinates and move on
			else
				knight_coordinates.delete_at(i)
			end
		end
		# Jump to the next spot if our checking variable says we haven't won yet
		jump(queue.shift, queue) if @won == 0
	end

	# We found the final coordinates!
	def show_winner(current_spot, path = [])
		# Until we get to the starting position (the label of the starting position is 0)
	 	unless current_spot.label == 0
	 		# Add to the beginning of our path array the current position
	 		path.unshift(current_spot.position)
	 		# Move on to the parent of the current position
	 		show_winner(current_spot.parent, path)
 		# We got to the starting position so...
	 	else
	 		# Add the starting position to the beginning of the array
	 		path.unshift(@start)
	 		# Show the winning message
	 		print "You made it in #{(path.length) - 1} moves! The quickest way from #{@start} to #{@stop} is "
	 		# Go through each coordinate in the path array...
	 		path.each_with_index do |spot, i|
	 			# Print it and show an arrow (->) as long as there are more coordinates to show
	 			# (Just for readability)
	 			print spot
	 			if i != path.length - 1
	 				print " -> "
	 			else
	 				puts
	 			end
	 		end
	 		# Because I like to see how many spaces the knight had to move to to find the ending position, I want to see the board. Every space that has "L:1" means the knight moved there on its travels. L = Label.
	 		view_board
	 	end
	end

	# Create the board by placing a new node 64 times
	def create_board
		@board = []
		@board_coord = []
		i = 0
		8.times do |y|
			8.times do |x|
				@board[i] = Node.new([x,y], i)
				# Add just the coordinates to another array. Makes looking through them later much easier
				@board_coord << [x,y]
				i += 1
			end
		end
	end

	# Show the board. This displays: 
	# L for Label (start = 0, end = 2, visited coordinates = 1)
	# I for Index (the index of the coordinate in the board array) and
	# P for Position. Just the coordinates on the board
	def view_board
		i = 0
		8.times do 
			8.times do 
				print "L:#{(@board[i].label).to_s.ljust(1)} " 
				print "I:#{(@board[i].index).to_s.ljust(2)} "
				print "P:#{(@board[i].position).to_s.ljust(2)} | "
				i += 1
			end
			puts
		end
	end

end

game = FindPath.new([0,7], [7,0])