defmodule ChartsTest do
  use ExUnit.Case

  test "the truth" do
    {:ok, data} = Poison.encode(%{x: [1,2,3], y: [4,5,6]})
    data = HTTPotion.post("localhost:4000/data?format=json", [body: data])
    |> Map.get(:body)
    |> Poison.decode!
    IO.inspect(data)
  end
end
