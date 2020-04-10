# frozen_string_literal: true

class Node
  attr_reader :key, :name, :left, :right

  def initialize(key, name)
    @key = key
    @name = name
  end

  def to_s
    "(key: #{key}, name: #{name}, left: #{left.name}, right: #{right.name})"
  end
end

class Tree
  def initialize
    @nodes = {}
  end

  def traversal(node, algorithm: :bfs)
    raise "Invalid strategy" unless [:pre, :in, :post].include?(algorithm)

    visited = {}
    nodes = [node]

    while nodes.any?
      current = (algorithm == :bfs ? nodes.shift : nodes.pop)
      next if visited[current]
      visited[current] = true
      yield current if block_given?
      nodes = nodes + current.adjacents
    end
  end
end

# tests 

n1 = Node.new(1, "A")
n2 = Node.new(2, "B")
n3 = Node.new(3, "C")
n4 = Node.new(4, "D")
n5 = Node.new(5, "E")
n6 = Node.new(6, "F")
n7 = Node.new(7, "G")

graph = Graph.new

graph.add_edge(n1, n2)
graph.add_edge(n1, n3)
graph.add_edge(n2, n4)
graph.add_edge(n2, n5)
graph.add_edge(n3, n6)
graph.add_edge(n3, n7)

require 'test/unit/assertions'
include Test::Unit::Assertions

expected = ["A", "B", "C", "D", "E", "F", "G"]
actual = []

graph.breadth_first(n1) do |node| 
  actual << node.name
end

assert_equal(actual, expected)


expected = ["A", "C", "G", "F", "B", "E", "D"]
actual = []

graph.depth_first(n1) do |node| 
  actual << node.name
end

assert_equal(actual, expected)
