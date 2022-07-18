def find_min_distance_nearest_zero(mat)
   rows = mat.size
   cols = mat[0].size

   dist = Array.new(rows) do
       Array.new(cols) do
           Float::INFINITY
       end
   end

   # top and left
   (0..rows - 1).each do |i|
       (0..cols - 1).each do |j|  
          if mat[i][j].zero?
               dist[i][j] = 0
           else
               if (i > 0)
                 dist[i][j] = [dist[i][j], dist[i-1][j] + 1].min
               end
               
               if (j > 0)
                 dist[i][j] = [dist[i][j], dist[i][j-1] + 1].min
               end
           end
       end
   end
    
    # top and left
    (0..rows - 1).reverse_each do |i|
       (0..cols - 1).reverse_each do |j|  
           if (i < rows - 1)
             dist[i][j] = [dist[i][j], dist[i+1][j] + 1].min
           end

           if (j < cols - 1)
             dist[i][j] = [dist[i][j], dist[i][j+1] + 1].min
           end
       end
   end

   dist
end

require 'test/unit/assertions'
include Test::Unit::Assertions

def test_simple_case
  input = [
     [0,0,0],
     [0,1,0],
     [0,0,0]
  ]
  expected = [
     [0,0,0],
     [0,1,0],
     [0,0,0]
  ]
  
  actual = find_min_distance_nearest_zero(input)
  assert_equal(actual, expected)
end

def test_large_case
  input = [
    [0,1,0,1,1],
    [1,1,0,0,1],
    [0,0,0,1,0],
    [1,0,1,1,1],
    [1,0,0,0,1]
  ]

  expected = [
    [0,1,0,1,2],
    [1,1,0,0,1],
    [0,0,0,1,0],
    [1,0,1,1,1],
    [1,0,0,0,1]
  ]

  actual = find_min_distance_nearest_zero(input)
  assert_equal(actual, expected)
end

test_simple_case
test_large_case
