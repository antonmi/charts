defmodule Charts.User do
  use Ecto.Model
  alias Charts.UserRepo

  schema "users" do
    field :username, :string
    field :passhash, :string
    field :token, :string
  end

  def changeset(user, params) do
    set = user |> cast(params, ~w(username), ~w()) |> validate_unique(:username, on: Charts.UserRepo)
    if String.length(params["password"]) < 6 do
      errors = [{:password, :too_short} | set.errors]
      set = %{set | valid?: false, errors: errors }
    end
    if params["password"] != params["confirm"] do
      errors = [{:password, :mishmatch} | set.errors]
      set = %{set | valid?: false, errors: errors }
    end
    set
  end

  def full_error_message(changeset) do
    Enum.map(changeset.errors, &Charts.User.error_message(&1)) |> Enum.join("\n")
  end

  def error_message({:password, :too_short}), do: "Password too short!"
  def error_message({:password, :mishmatch}), do: "Password and confirmation mishmatch!"
  def error_message({:username, :unique}), do: "User already exists!"

end
