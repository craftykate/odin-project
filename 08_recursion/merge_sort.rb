def merge_sort(arr)
	return arr if arr.length <= 1
	half = arr.length/2
	arr1 = arr[0..half - 1]
	arr2 = arr[half..-1]
	arr1 = merge_sort(arr1)
	arr2 = merge_sort(arr2)
	merge(arr1, arr2)
end

def merge(arr1, arr2)
	answer = []
	while arr1.length > 0 && arr2.length > 0
		if arr1[0] <= arr2[0]
			answer << arr1.shift
		else
			answer << arr2.shift
		end
	end
	if arr1.length > 0
		answer.concat arr1
	elsif arr2.length > 0
		answer.concat arr2
	end
	answer
end

print merge_sort([4,56,12,15,65,6,9]) # => [4,6,9,12,15,56,65]
