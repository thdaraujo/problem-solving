# minmaxdivision
# broken solution
def solution(k, max, a)
  # write your code in Ruby 2.2
  binary_search(k, max, a)
end

def binary_search(max_blocks, max, a)
  low = a.max
  high = a.inject(:+)
  
  return high if max_blocks == 1
  return low if max_blocks >= a.size
      
  loop do
    middle = (low + high) / 2
    blocks = blocks(a, middle, max_blocks)
    if blocks < max_blocks
      high = middle - 1
    elsif blocks > max_blocks
      low = middle + 1
    else
      return high
    end
  end
end

def blocks(a, max_sum, max_blocks)
  count = 0
  sum = a[0]
  (1...a.size).each do |i|
    if (sum + a[i]) > max_sum
        count += 1
        sum = a[i]
    else
      sum = sum + a[i]
    end
    return count if count > max_blocks # break
  end
  count
end
