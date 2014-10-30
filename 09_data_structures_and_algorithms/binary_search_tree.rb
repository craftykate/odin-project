class Node
	attr_accessor :value, :left_child, :right_child, :count

	def initialize(value)
		@value = value
		@left_child = nil
		@right_child = nil
		@count = 1
	end

end

class BinaryTree

	def initialize(arr)
		@parent_node = nil
		build_tree(arr)
	end

	def build_tree(arr)
		# If the array was sorted, this will go from the middle and get items from each side, in an attempt to make the binary tree fairly even. If the array isn't sorted, then it's all the same. 
		# Grab an item, insert that item as a node, delete that item from the array
		until arr.length == 0
			item = arr.length / 2
			insert_node(arr[item], @parent_node)
			arr.delete_at(item)
			if arr.length != 0
				item = (arr.length*0.3).floor
				insert_node(arr[item], @parent_node)
				arr.delete_at(item)
			end
			if arr.length != 0
				item = (arr.length*0.6).floor
				insert_node(arr[item], @parent_node)
				arr.delete_at(item)
			end
		end
	end

	def insert_node(item, parent_node)
		# If there's no @parent_node, this is the parent node
		if @parent_node == nil
			@parent_node = Node.new(item)
		else
			# If the item is already in the data tree, increase the count of that node by 1
			if item == parent_node.value
				parent_node.count += 1
			# If the item is less than the node being checked, and that space is empty, add that item to the left
			elsif item < parent_node.value
				if parent_node.left_child == nil
					parent_node.left_child = Node.new(item)
				# The left node is not empty, so try the NEXT branch down
				else
					insert_node(item, parent_node.left_child)
				end
			# Item is greater that node being checked. If the right node is empty, put it there, otherwise check the next branch down
			else
				if parent_node.right_child == nil
					parent_node.right_child = Node.new(item)
				else
					insert_node(item, parent_node.right_child)
				end
			end
		end
	end

	# Display the tree
	def view_tree(current_node = @parent_node)
		c = current_node.value
		l = current_node.left_child == nil ? "nil" : current_node.left_child.value
		r = current_node.right_child == nil ? "nil" : current_node.right_child.value
		puts "Node #{c} (#{current_node.count} of them): Left: #{l} | Right: #{r}" 
		view_tree(current_node.left_child) if current_node.left_child != nil
		view_tree(current_node.right_child) if current_node.right_child != nil
	end

	def breadth_first_search(item, current_node = @parent_node, result = [], queue = [])
		result << current_node.value
		if item == current_node.value
			return "Your item \"#{item}\" was found: #{result}. Node: #{current_node}"
		else
			if current_node.left_child != nil
				if current_node.left_child.value == item
					result << current_node.left_child.value
					return "Your item \"#{item}\" was found: #{result}. Node: #{current_node.left_child}"
				end
				queue << current_node.left_child
			end
			if current_node.right_child != nil
				if current_node.right_child.value == item
					result << current_node.right_child.value
					return "Your item \"#{item}\" was found: #{result}. Node: #{current_node.right_child}"
				end
				queue << current_node.right_child
			end
			if current_node.left_child == nil && current_node.right_child == nil
				return "Your item \"#{item}\" was not found."
			end
		end
		next_item = queue.shift
		breadth_first_search(item, next_item, result, queue)
	end


	def depth_first_search(item, current_node = @parent_node, result = [], stack = [])
		stack << current_node if result.length == 0
		result << current_node.value if (result.include?(current_node.value) == false)
		if item == current_node.value
			return "Your item \"#{item}\" was found: #{result}. Node: #{current_node}"
		else
			if current_node.left_child != nil && (result.include?(current_node.left_child.value) == false)
				if current_node.left_child.value == item
					result << current_node.left_child.value
					return "Your item \"#{item}\" was found: #{result}. Node: #{current_node}"
				end
				stack << current_node.left_child
				depth_first_search(item, current_node.left_child, result, stack)
			else
				if current_node.right_child != nil
					if current_node.right_child.value == item
						result << current_node.right_child.value
						return "Your item \"#{item}\" was found: #{result}. Node: #{current_node}"
					end
					stack << current_node.right_child
					depth_first_search(item, current_node.right_child, result, stack)
				else
					if stack.length == 0
						return "Your item \"#{item}\" was not found. "
					else
						next_item = stack.pop
						depth_first_search(item, next_item, result, stack)
					end
				end
			end
		end
	end

	protected :insert_node

end

arr = [1,2,3,4,5,6,7,8,9,10]
tree = BinaryTree.new(arr)

tree.view_tree
puts tree.breadth_first_search(8)
puts tree.depth_first_search(8)