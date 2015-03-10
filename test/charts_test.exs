defmodule ChartsTest do
  use ExUnit.Case

  test "the truth" do
    {:ok, data} = Poison.encode(%{x: [1,2,3], y: [4,5,6]})
    HTTPoison.post("localhost:4000/data", {:form, [data: data]}
    |> Map.get(:body)
    |> Poison.decode!
    IO.inspect(data)
  end

  test "push to channel" do
    Phoenix.Channel.broadcast(Charts.PubSub, %Phoenix.Socket{topic: "data:source"}, "new:msg", %{qqq: :www})

    Phoenix.Channel.broadcast_from(Charts.PubSub, self, "data:source", "new:msg", %{qqq: :wwwweqqwe})
  end
end
