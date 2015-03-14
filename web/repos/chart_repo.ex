defmodule Charts.ChartRepo do
  use Charts.BaseRepo

  def create(type, title, user_id) do
    chart = %Charts.Chart{type: type, title: title, user_id: user_id}
    Charts.Repo.insert(chart)
  end

  def all_for_user(user) do
    query = from c in Charts.Chart, where: c.user_id == ^user.id, select: c
    Charts.Repo.all(query)
  end

  def for_user(user, id) do
    query = from c in Charts.Chart, where: c.user_id == ^user.id and c.id == ^id, select: c
    Charts.Repo.all(query) |> List.first
  end


end
