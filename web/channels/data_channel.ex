defmodule Charts.DataChannel do
  use Phoenix.Channel

  require IEx

  def join(channel, _message, socket) do
    token = String.split(channel, ":") |> List.last
    user = Charts.UserRepo.find_by_token(token)
    if user do
      reply socket, "join", %{ hey: "Hello!" }
      {:ok, socket}
    else
      {:error, :access_denied, socket}
    end
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
