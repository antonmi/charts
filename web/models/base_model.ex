defmodule Charts.BaseModel do

  defmacro __using__(_opts) do
    quote do
      use Ecto.Model

      def full_error_message(changeset) do
        Enum.map(changeset.errors, &__MODULE__.error_message(&1)) |> Enum.join("\n")
      end
    end
  end
  
end
