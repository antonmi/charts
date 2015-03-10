defmodule Charts.User do
  use Ecto.Model
  alias Charts.UserRepo

  schema "users" do
    field :username, :string
    field :passhash, :string
  end

end
