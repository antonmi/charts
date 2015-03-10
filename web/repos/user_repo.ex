defmodule Charts.UserRepo do
  use Charts.BaseRepo

  def create(username, password) do
    passhash = Charts.Crypto.md5(password)
    user = %Charts.User{username: username, passhash: passhash}
    if exist?(username), do: false, else: Charts.Repo.insert(user)
  end

  #find_by_username and etc
  
  ["username"] |> Enum.each fn(attr) ->
    def unquote(String.to_atom("find_by_#{attr}"))(value) do
      query = from u in Charts.User, where: u.username == ^value, select: u
      Charts.Repo.all(query) |> List.first
    end
  end

  def exist?(username) do
    if find_by_username(username), do: false, else: true
  end

end
