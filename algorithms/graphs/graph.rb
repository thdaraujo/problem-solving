# frozen_string_literal: true

class Node
  attr_reader :key, :name, :adjacents

  def initialize(key, name)
    @key = key
    @name = name
    @adjacents = []
  end

  def to_s
    "(key: #{key}, name: #{name}, adjacents: #{adjacents.map(&:name)})"
  end
end

class Graph

  def initialize
    @nodes = {}
    @edges = {}
  end

  def add_node(node)
    @nodes[node.key] = node

    node.adjacents.each do |adj|
      edge = [node.key, adj.key]
      @edges[edge] = [node, adj]
    end
  end

  def add_edge(node_a, node_b)
    node_a.adjacents << node_b
    node_b.adjacents << node_a

    add_node(node_a)
    add_node(node_b)
  end

  def nodes
    @nodes.values
  end

  def edges
    @edges.values
  end

  def traversal(node, algorithm: :bfs)
    raise "Invalid strategy" unless [:bfs, :dfs].include?(algorithm)

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

  def breadth_first(node)
    traversal(node, algorithm: :bfs) do |current|
      yield current if block_given?
    end
  end

  def depth_first(node)
    traversal(node, algorithm: :dfs) do |current|
      yield current if block_given?
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
