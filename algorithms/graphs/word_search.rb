def adjacent_coords(board, row, col)
   rows = board.size
   cols = board.first.size  

   [        
        [row-1, col],
        [row, col+1],
        [row+1, col],
        [row, col-1]
    ].reject {|x, y| x.negative? || y.negative? || x >= rows || y >= cols }
end

def dfs(board)
    row, col = 0, 0
    nodes = [[row, col]]
    visited = {}
    
    while nodes.any?
        row, col = nodes.pop
        next if visited[[row, col]]
        value = board[row][col]
        visited[[row, col]] = true
        
        yield [row, col, value] if block_given?
        
        adj = adj_coords(board, row, col)
        nodes = nodes + adj.reverse
    end
    
    visited.keys
end

require 'test/unit/assertions'
include Test::Unit::Assertions

board = [
  ['a', 'b'],
  ['c', 'd']
]

expected =  ['a', 'b', 'd', 'c']
actual = []

dfs(board) do |row, col, letter|
    actual << letter
end

assert_equal(actual, expected)
