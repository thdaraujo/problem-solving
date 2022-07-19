# return the indices of numbers
# that sum up to target
def two_sum_indices(nums, target)
    dp = {}
    
    nums.each.with_index do |num, i|
        diff = target - num
        if dp[diff]
            return [i, dp[diff]]
        end

        dp[num] = i
    end
    
    nil
end

# quadratic
def two_sum_naive(nums, target)
    nums.each.with_index do |num, i|
        (i+1...nums.size).each do |j|
            return [i,j] if num + nums[j] == target
        end
    end
end

require 'test/unit/assertions'
include Test::Unit::Assertions

def test_simple_case
  expected = [1, 0]
  actual = two_sum_indices([2, 7, 11, 15], 9)

  assert_equal(actual, expected)
end

test_simple_case
