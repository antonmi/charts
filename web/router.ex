defmodule Charts.Router do
  use Phoenix.Router

  pipeline :browser do
    plug :accepts, ~w(html)
    plug :fetch_session
    plug :fetch_flash
    # plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ~w(json)
  end

  scope "/", Charts do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  #Other scopes may use custom stacks.
  scope "/", Charts do
    pipe_through :api
    post "/data", DataController, :create
  end

  socket "/ws", Charts do
    channel "data:*", DataChannel
  end
end
