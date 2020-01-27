defmodule Combine do
    def combination(0, _), do: [[]]
    def combination(_, []), do: []
    def combination(m, [h|t]) do
        (for l <- combination(m-1, t), do: [h|l]) ++ combination(m, t)
    end

    def combination(m, l..h), do: combination(m, Enum.to_list(l..h))
end

defmodule MissingEdges do
    def call(x, _) when x <= 1, do: []
    def call(n, edges) do
      edges = edges |> Enum.map(fn v -> MapSet.new(v) end)

      all_edges = Combine.combination(2, 0..n-1)
                  |> Enum.map(fn v -> MapSet.new(v) end)

      (all_edges -- edges) |> Enum.map(fn m -> MapSet.to_list(m) end)
    end
end

ExUnit.start

defmodule MissingEdgesTest do
  use ExUnit.Case  

  test "trivial_graph_test" do
    assert MissingEdges.call(1, []) == []
  end

  test "no_missing_edges_test" do
    n = 3
    edges = [[0,1], [1,2], [0,2]]
    actual = MissingEdges.call(n, edges)
    assert actual == []
  end

    test "some_missing_edges_test" do
        n = 4
        edges = [[0,1], [1,2], [2,0]]
        actual = MissingEdges.call(n, edges)
        expected = [[0,3], [1,3], [2,3]]
        assert actual == expected
    end
end


# how to run:
# $ elixir complete_graph_missing_edge.exs
