defmodule Charts.DataController do
  use Phoenix.Controller

  plug :action

  def create(conn, data) do
    json conn, %{ok: "Fuck"}
  end
end
