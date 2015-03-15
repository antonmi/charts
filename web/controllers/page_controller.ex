defmodule Charts.PageController do
  use Phoenix.Controller

  plug :action

  def test(conn, _params) do
    text conn, "Hello"
  end
end
