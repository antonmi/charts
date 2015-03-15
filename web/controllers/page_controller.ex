defmodule Charts.PageController do
  use Phoenix.Controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end
  
  def test(conn, _params) do
    text conn, "Hello"
  end

end
