defmodule ChartsTest do
  use ExUnit.Case

  # test "the truth" do
  #   {:ok, data} = Poison.encode(%{x: [1,2,3], y: [4,5,6]})
  #   HTTPoison.post("localhost:4000/data", {:form, [data: data]})
  #   |> Map.get(:body)
  #   |> Poison.decode!
  #   IO.inspect(data)
  # end
  #
  # test "push to channel" do
  #   Phoenix.Channel.broadcast(Charts.PubSub, %Phoenix.Socket{topic: "data:source"}, "new:msg", %{qqq: :www})
  #
  #   Phoenix.Channel.broadcast_from(Charts.PubSub, self, "data:source", "new:msg", %{qqq: :wwwweqqwe})
  # end

  test "with data" do
    (1..1000) |> Enum.each fn(i) ->
      data =   [
        ["Year", "Sales", "Expenses"],
        ["2004",  2000,      1400],
        ["2005",  1170,      460+10],
        ["2006",  1660,       1120],
        ["2007",  1030,      540]
      ]
      {:ok, data} = Poison.encode(data)
      HTTPoison.post("localhost:4000/api/charts/5/data", {:form, [data: data]})
    end
  end
end
