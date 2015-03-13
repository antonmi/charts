defmodule Charts.API.ChartsController do

  use Charts.API.BaseController


  # data =   [
  #     ["Year", "Sales", "Expenses"],
  #     ["2004",  1000,      400],
  #     ["2005",  1170,      460],
  #     ["2006",  660,       1120],
  #     ["2007",  1030,      540]
  #   ]

  def show(conn, params) do
    chart = Charts.ChartRepo.find(params["id"])
    json conn, %{data: chart.data}
  end

  def data(conn, params) do
    chart = Charts.ChartRepo.find(params["id"])
    user = Charts.UserRepo.find_by_token(params["token"])
    if (chart && user) && chart.user_id == user.id do
      chart = %{chart | data: params["data"]}
      Charts.Repo.update(chart)
      Phoenix.Channel.broadcast_from(Charts.PubSub, self, "data:source", "update", %{})
      json conn, %{}
    else
      conn |> put_status(404) |> json(%{})
    end
  end

end
