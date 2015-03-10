defmodule Charts.API.BaseController do

  defmacro __using__(_opts) do
    quote do
      use Phoenix.Controller
      plug :action

    end
  end
end
