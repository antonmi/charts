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

  scope "/:username", Charts do
    pipe_through :browser # Use the default browser stack

    resources "/line_charts", LineChartsController
  end


  #Other scopes may use custom stacks.
  scope "/api", Charts do
    pipe_through :api

    post "/line_charts/:id/data", API.LineChartController, :data
  end

  socket "/ws", Charts do
    channel "data:*", DataChannel
  end
end
