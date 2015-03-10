defmodule Charts.Chart do
  use Ecto.Model

  schema "charts" do
    field :type, :string
    field :user_id, :integer
    field :data, :string
  end

end
