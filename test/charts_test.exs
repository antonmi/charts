defmodule ChartsTest do
  use ExUnit.Case

  @tag timeout: :infinity
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
    (1..100) |> Enum.each fn(i) ->
      {:ok, data} = Poison.encode(data(i))
      :timer.sleep(500)
      response = HTTPoison.post(url, {:form, [data: data]})
      IO.puts(inspect response)
    end
  end

  # defp url, do: "http://localhost:4000/api/charts/2/data/2c578e2c471e3ccae7056de9f87653da"
  defp url, do: "http://live-charts.herokuapp.com:80/api/charts/1/data/9f6c6935b9a4e45b43c7ed0b7e9a15ba"

  defp data(i) do
    [
     ["Year", "Sales", "Expenses"],
     ["2004",  2000,      1400],
     ["2005",  1170,      460+50*i],
     ["2006",  1660,       1120],
     ["2007",  1030,      540]
   ]
  end
end
