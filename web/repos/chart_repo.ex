defmodule Charts.ChartRepo do
  use Charts.BaseRepo

  def create(type, user_id, data) do
    chart = %Charts.Chart{type: type, user_id: user_id, data: data}
    Charts.Repo.insert(chart)
  end

  

end
