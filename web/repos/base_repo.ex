defmodule Charts.BaseRepo do

  defmacro __using__(_opts) do
    quote do
      import Ecto.Query

      #common methods here

    end
  end

end
