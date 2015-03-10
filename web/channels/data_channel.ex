defmodule Charts.DataChannel do
  use Phoenix.Channel

  def join("data:source", _message, socket) do
    reply socket, "join", %{ hey: "Hello!" }
    {:ok, socket}
  end

  def leave(reason, socket) do
    IO.puts "LEAVE"
    {:ok, socket}
  end

  def handle_in("new:msg", message, socket) do
    IO.puts "HANDLE_IN"
    broadcast socket, "new:msg", message
    {:ok, socket}
  end

  def handle_out(event, message, socket) do
    IO.puts "HANDLE_OUT"
    reply socket, event, message
    {:ok, socket}
  end

end
