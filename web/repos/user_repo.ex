defmodule Charts.UserRepo do
  use Charts.BaseRepo

  def create(username, password) do
    passhash = Charts.Crypto.md5(password)
    user = %Charts.User{username: username, passhash: passhash}
    Charts.Repo.insert(user)
  end

  def set_password(user, password) do
    passhash = Charts.Crypto.md5(password)
    user = %Charts.User{user | passhash: passhash}
    Charts.Repo.update(user)
  end

  def set_token(user) do
    Charts.RepoCache.del(__MODULE__, user.token)
    user = %Charts.User{user | token: Charts.Crypto.rand() }
    Charts.Repo.update(user)
  end

  def find_by_username(name) do
    query = from u in Charts.User, where: u.username == ^name, select: u
    Charts.Repo.all(query) |> List.first
  end

  def find_by_token(token) do
    query = from u in Charts.User, where: u.token == ^token, select: u
    Charts.Repo.all(query) |> List.first
  end

  def find_with_cache_by_token(token) do
    user = Charts.RepoCache.get(__MODULE__, token)
    unless user do
      user = find_by_token(token)
      Charts.RepoCache.set(__MODULE__, token, user)
    end
    user
  end

  def exist?(username) do
    if find_by_username(username), do: true, else: false
  end

end
