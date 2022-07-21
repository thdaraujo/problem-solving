def spiral_order(matrix)
#  return matrix[0] if matrix.size == 1

  walker = SpiralWalker.new(matrix)

  walker.map do |item|
    item
  end
end

class SpiralWalker
  include Enumerable

  DIRECTIONS = %i[right down left up]

  def initialize(matrix)
    @index = 0
    @matrix = matrix
    @row = 0
    @col = 0
    @visited = {[0, 0] => true}
    @ended = false
  end

  def each(&block)
    loop do
      block.call(current_position)      
      break if !self.walk!
    end
  end

  private

  def walk!
    return false if @ended

    # lookahead
    if !accessible?(next_coordinates(current_direction))
      change_direction!

      if !accessible?(next_coordinates(current_direction))
        @ended = true
        return false
      end
    end

    @row, @col = next_coordinates(current_direction)
    visit([@row, col])
    
    true
  end

  def current_position
    matrix[row][col]
  end

  def current_coordinates
    [row, col]
  end

  COORDINATES_DELTA = {
    right: [0, 1],
    down: [1, 0],
    left: [0, -1],
    up: [-1, 0]
  }
  def next_coordinates(direction)
    delta_x, delta_y = COORDINATES_DELTA[direction]
    [row + delta_x, col + delta_y]
  end

  def current_direction
    DIRECTIONS[@index]
  end

  def change_direction!
    DIRECTIONS[next_index!]
  end

  def next_index!
    if @index < DIRECTIONS.size - 1
      @index += 1
    else
      @index = 0
    end
  end

  def accessible?(coordinates)
    return false if visited?(coordinates)

    x, y = coordinates

    max_x = matrix.size - 1
    max_y = matrix[0].size - 1

    x >= 0 && y >= 0 && x <= max_x && y <= max_y
  end

  def visited?(coordinates)
    @visited[coordinates] == true
  end

  def visit(coordinates)
    @visited[coordinates] = true
  end

  attr_reader :row, :col, :matrix
end

require "test/unit/assertions"
include Test::Unit::Assertions

def test_simple_case
  expected = [1, 2, 3, 6, 9, 8, 7, 4, 5]
  actual = spiral_order([[1, 2, 3], [4, 5, 6], [7, 8, 9]])

  assert_equal(expected, actual)
end

def test_large_case
  actual = spiral_order([[1,2,3,4],[5,6,7,8],[9,10,11,12]])
  assert_equal([1,2,3,4,8,12,11,10,9,5,6,7], actual)
end

def test_base_case
  assert_equal([1], spiral_order([[1]]))
end

def test_weird_case
  assert_equal([3,2], spiral_order([[3],[2]]))
end

test_simple_case
test_large_case
test_base_case
test_weird_case