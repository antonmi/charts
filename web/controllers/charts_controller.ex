defmodule Charts.ChartsController do
  use Charts.BaseController

  @chart_type "line_chart"

  plug :auth
  plug :action


  def show(conn, params) do
    chart = Charts.ChartRepo.find(params["id"])
    render conn, "show.html", chart: chart
  end


end
