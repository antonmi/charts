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

    get "/test", PageController, :test
    resources "/users", UsersController, only: [:new, :create]
    get "/users/login", UsersController, :login
    get "/users/:id/logout", UsersController, :logout
    post "/user/process_login", UsersController, :process_login
  end

  #Other scopes may use custom stacks.
  scope "/api", Charts, as: :api do
    pipe_through :api

    get "/charts/:id/:token", API.ChartsController, :show
    post "/charts/:id/data/:token", API.ChartsController, :data
  end


  scope "/:user_id", Charts do
    pipe_through :browser # Use the default browser stack
    get "/dashboard", UsersController, :dashboard
    get "/settings", UsersController, :settings
    patch "/token", UsersController, :token
    resources "/charts", ChartsController
  end




  socket "/ws", Charts do
    channel "data:*", DataChannel
  end
end
