defmodule Charts.API.BaseController do

  defmacro __using__(_opts) do
    quote do
      use Phoenix.Controller
      require IEx
      

    end
  end
end
