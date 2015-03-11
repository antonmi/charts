defmodule Charts.UserRepo do
  use Charts.BaseRepo

  def create(username, password) do
    passhash = Charts.Crypto.md5(password)
    user = %Charts.User{username: username, passhash: passhash}
    if exist?(username), do: false, else: Charts.Repo.insert(user)
  end

  def find_by_username(name) do
    query = from u in Charts.User, where: u.username == ^name, select: u
    Charts.Repo.all(query) |> List.first
  end

  def exist?(username) do
    if find_by_username(username), do: true, else: false
  end

end
