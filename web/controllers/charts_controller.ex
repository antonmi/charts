defmodule Charts.ChartsController do
  use Charts.BaseController

  @chart_type "line_chart"

  plug :auth
  plug :action


  def show(conn, params) do
    chart = Charts.ChartRepo.find(params["id"])
    render conn, "show.html", chart: chart
  end

  def new(conn, params) do
    render conn, "new.html", changeset: %Ecto.Changeset{changes: %{title: "", type: ""}}
  end

  def create(conn, params) do
    changeset  = Charts.Chart.changeset(%Charts.Chart{}, params)
    IO.puts(inspect changeset)
    if changeset.valid? do
      chart = Charts.ChartRepo.create(params["type"], params["title"], current_user(conn).id)
      conn |> put_flash(:notice, "Chart created!")
      |> redirect to: charts_path(conn, :show, current_user(conn).id, chart.id)
    else
      conn |> put_flash(:error, Charts.Chart.full_error_message(changeset))
      |> render "new.html", changeset: changeset
    end
  end


end
