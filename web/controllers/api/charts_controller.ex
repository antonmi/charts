defmodule Charts.API.ChartsController do

  use Charts.API.BaseController

  plug :authorize
  plug :action
  # data =   [
  #     ["Year", "Sales", "Expenses"],
  #     ["2004",  1000,      400],
  #     ["2005",  1170,      460],
  #     ["2006",  660,       1120],
  #     ["2007",  1030,      540]
  #   ]

  def show(conn, params) do
    json conn, %{data: chart(conn).data}
  end

  def data(conn, params) do
    chart = %{chart(conn) | data: params["data"]}
    Charts.Repo.update(chart)
    Phoenix.Channel.broadcast_from(Charts.PubSub, self, "data:#{user(conn).token}", "update", %{})
    json conn, %{}
  end

  defp authorize(conn, args) do
    chart = Charts.ChartRepo.find_with_cache(conn.params["id"])
    user = Charts.UserRepo.find_with_cache_by_token(conn.params["token"])
    if (chart && user) && chart.user_id == user.id do
      conn |> assign(:chart, chart) |> assign(:user, user)
    else
      conn |> put_status(404) |> json(%{}) |> halt
    end
  end

  defp chart(conn), do: conn.assigns[:chart]

  defp user(conn), do: conn.assigns[:user]

end
