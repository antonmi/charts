defmodule Charts.Crypto do
  def md5(str) do
    :crypto.hash(:md5, str)
      |> :erlang.bitstring_to_list
      |> Enum.map(&(:io_lib.format("~2.16.0b", [&1])))
      |> List.flatten
      |> :erlang.list_to_bitstring
  end

  def rand() do
    {mega, sec, micro} = :os.timestamp()
    Integer.to_string(mega + sec + micro) |> md5
  end
end
