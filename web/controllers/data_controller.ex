defmodule Charts.DataController do
  use Phoenix.Controller

  require IEx

  plug :action

  def create(conn, params) do
    IO.puts inspect(params)
    Phoenix.Channel.broadcast_from(Charts.PubSub, self, "data:source", "new:msg", params)
    json conn, %{ok: "Fuck"}
  end
end
