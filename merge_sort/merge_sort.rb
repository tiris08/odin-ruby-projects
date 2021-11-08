def merge (arr1, arr2)
  merged = []
    until arr1.empty? && arr2.empty? do
      if arr1.empty? 
        merged << arr2.shift
      elsif arr2.empty?
        merged << arr1.shift
      elsif arr1[0] < arr2[0]
        merged << arr1.shift
      else
        merged << arr2.shift
      end
    end
    merged
end

def merge_sort(arr)
  if arr.length < 2 
    arr
  else 
    arrleft = merge_sort(arr.slice!(0, arr.length/2))
    arrright = merge_sort(arr)
    result = merge(arrleft, arrright)
  end
end
