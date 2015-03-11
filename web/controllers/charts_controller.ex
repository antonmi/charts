defmodule Charts.ChartsController do
  use Charts.BaseController

  @chart_type "line_chart"

  plug :action


  def show(conn, params) do
    chart = Charts.ChartRepo.find(params["id"])
    render conn, "show.html", chart: chart
  end

  def data(conn, params) do
    
  end
end
