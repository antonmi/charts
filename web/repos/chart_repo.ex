defmodule Charts.ChartRepo do
  use Charts.BaseRepo

  def create(type, title, user_id, data \\ "") do
    chart = %Charts.Chart{type: type, title: title, user_id: user_id, data: data}
    Charts.Repo.insert(chart)
  end



end
