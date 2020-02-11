# frozen_string_literal: true

require 'test/unit/assertions'
include Test::Unit::Assertions

# A minefield is made up of mines placed on a continuous 2D plane. 
# A mine is represented as an array with the values [x, y, blast_radius]. 
# When a mine blows up, all other mines whose coordinates are within the 
# blast radius also blow up. When those mines blow up, any mines within 
# their blast radius also blow up, and so on and so on, triggering a chain reaction.
# 
# Given a list of mines, determine which mine would blow the most total 
# number of mines if it were to blow up. The output should be 
# the mine and the total number of mines that it blows up, including itself. 
#

Mine = Struct.new(:x, :y, :blast_radius, :border) do
  def to_a
    [x, y, blast_radius]
  end
end

def most_blown_up(mines)
  mines = mines.map do |mine|
    Mine.new(mine[0], mine[1], mine[2], [])
  end

  mines.combination(2).each do |a, b|
    dist = distance(a, b)
    if dist <= a.blast_radius
      a.border << b
    end

    if dist <= b.blast_radius
      b.border << a
    end
  end

  counts = mines.map do |mine|
    count = count_explosions_for(mine)
    { mine: mine.to_a, count: count }
  end

  counts.max_by{|h| h[:count] }
end

def count_explosions_for(mine)
  visited = [mine]
  queue = [mine]

  while queue.any?
    current = queue.shift
    current.border.each do |adj|
      next if visited.include?(adj)
      queue << adj
      visited << adj
    end
  end
  visited.size
end

def distance(a, b)
  Math.sqrt((b.x - a.x) ** 2 + (b.y - a.y) ** 2)
end

def larger_test_case
  mines = [
    [7.0, 13.0, 3.0],
    [6.5, 17.0, 5.0],
    [12.0, 10.0, 4.5],
    [14.5, 7.0, 3.5],
    [17.0, 9.0, 2.0],
    [7.0, 11.0, 2.5],
    [8.5, 11.5, 3.0],
  ]

  expected = { mine: [12.0, 10.0, 4.5], count: 6 }
  actual = most_blown_up(mines) 

  assert_equal actual, expected
end

# test cases
larger_test_case
