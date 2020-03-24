# frozen_string_literal: true

require 'test/unit/assertions'
include Test::Unit::Assertions

# given `n` as the number of nodes in a network
# and `edges` as the list of edges connecting two nodes
# find the list of missing edges to be added to the graph
# to make it a complete undirected graph
# where every node is connected to all the others

def missing_edges(n, edges)
  all_edges = (0...n).to_a.combination(2).to_a
  all_edges - edges.map(&:sort)
end

# trivial graph
def trivial_graph_test
  n = 1
  edges = []
  actual = missing_edges(n, edges)
  expected = []
  assert_equal(actual, expected)
end

# no missing edges
def no_missing_edges_test
  n = 3
  edges = [[0, 1], [1, 2], [0, 2]]
  actual = missing_edges(n, edges)
  expected = []

  assert_equal actual, expected
end

# some missing edges
def some_missing_edges_test
  n = 4
  edges = [[0, 1], [1, 2], [2, 0]]
  actual = missing_edges(n, edges)
  expected = [[0, 3], [1, 3], [2, 3]]

  assert_equal(actual, expected)
end

# run test suite

trivial_graph_test
no_missing_edges_test
some_missing_edges_test
