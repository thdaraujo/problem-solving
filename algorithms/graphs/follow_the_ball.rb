def find_ball(grid)
    max_cols = grid[0].size
    
    (0...max_cols).map do |ball|
        @ball_1 = ball
        follow_ball(grid, ball, max_cols)
    end
end

def follow_ball(grid, ball, max_cols)
    grid.each.with_index do |row, i|
       if stuck?(ball, row, max_cols)
           return -1
       end        
        
       ball += row[ball]
    end
    
    ball
end

def stuck?(index, row, max_cols)
    value = row[index]
    
    # will get stuck on either side
    if (index == 0 && value == -1) || (index == max_cols - 1 && value == 1)
        true
    # right and right-neighbour is left
    elsif value == 1 && row[index + 1] == -1
        true
    # left and left-neighbour is right
    elsif value == -1 && row[index - 1] == 1
        true
    else
        false
    end
end

require "test/unit/assertions"
include Test::Unit::Assertions

input = [[1,1,1,-1,-1],[1,1,1,-1,-1],[-1,-1,-1,1,1],[1,1,1,1,-1],[-1,-1,-1,-1,-1]]
expected = [1,-1,-1,-1,-1]

assert_equal(expected, find_ball(input))

assert_equal([-1], find_ball([[-1]]))

assert_equal(
    [0,1,2,3,4,-1],
    find_ball([[1,1,1,1,1,1],[-1,-1,-1,-1,-1,-1],[1,1,1,1,1,1],[-1,-1,-1,-1,-1,-1]]) # left right left right
)