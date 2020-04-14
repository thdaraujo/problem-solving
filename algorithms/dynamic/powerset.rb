def powerset(set)
    (0..set.size).flat_map do |size|
        set.combination(size).to_a
    end
end

require 'test/unit/assertions'
include Test::Unit::Assertions

assert_equal [[]], powerset([])
assert_equal [[], [1]], powerset([1])
assert_equal [[], [1], [2], [1,2]], powerset([1,2])
assert_equal [[], [1], [2], [3], [1,2], [1,3], [2,3], [1,2,3]], powerset([1,2,3])
