defmodule Charts.BaseRepo do

  defmacro __using__(_opts) do
    quote do
      import Ecto.Query


      #common methods here
      def find(id) do
        module = Atom.to_string(__MODULE__) |> String.split("Repo") |> List.first
        Charts.Repo.get(String.to_atom(module), id)
      end

    end
  end

end
