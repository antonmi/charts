defmodule Charts.BaseRepo do

  defmacro __using__(_opts) do
    quote do
      import Ecto.Query
      alias Charts.Repo

      #common methods here
      def find(id), do: Repo.get(module, id)
      
      def all(), do: Repo.all(from m in module, select: m)
      def all(query), do: Repo.all(query)

      defp module() do
        Atom.to_string(__MODULE__) |> String.split("Repo")
        |> List.first |> String.to_atom
      end


    end
  end

end
