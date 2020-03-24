# frozen_string_literal: true

# require 'test/unit/assertions'
# include Test::Unit::Assertions

require 'set'

class Node
  attr_reader :key, :name
  attr_accessor :adjacents

  def initialize(key, name)
    @key = key
    @name = name
    @adjacents = Set.new
  end
end

class Graph
  attr_reader :edges

  def initialize
    @nodes = {}
    @edges = {}
  end

  def add_node(node)
    @nodes[node.key] = node

    node.adjacents.each do |adj|
      edge = Set.new([node.key, adj.key])
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

  def bfs(source_node, visited = [])
    queue = []
    queue << source_node
    visited << source_node

    while queue.any?
      current_node = queue.shift # dequeue
      puts "visited node #{current_node.name}"

      current_node.adjacents.each do |adjacent_node|
        next if visited.include?(adjacent_node)

        queue << adjacent_node
        visited << adjacent_node
      end
    end
  end

  def dfs(node, visited = [])
    puts "visited node #{node.name}"
    visited << node
    node.adjacents.each do |adj_node|
      next if visited.include?(adj_node)

      dfs(adj_node, visited)
    end
  end
end


n1 = Node.new(1, "A")
n2 = Node.new(1, "B")
n3 = Node.new(1, "C")
n4 = Node.new(1, "D")
n5 = Node.new(1, "E")
n6 = Node.new(1, "F")
n7 = Node.new(1, "G")

graph = Graph.new

graph.add_node(n1)
graph.add_node(n2)
graph.add_node(n3)
graph.add_node(n4)
graph.add_node(n5)
graph.add_node(n6)
graph.add_node(n7)

graph.add_edge(n1, n2)
graph.add_edge(n1, n3)
graph.add_edge(n2, n4)
graph.add_edge(n2, n5)
graph.add_edge(n3, n6)
graph.add_edge(n3, n7)

puts "bfs"
graph.bfs(n1)

puts "bfs"
graph.dfs(n1)