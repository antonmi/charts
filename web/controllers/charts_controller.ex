defmodule Charts.ChartsController do
  use Charts.BaseController

  @chart_type "line_chart"

  plug :auth
  plug :action

  def index(conn, params) do
    charts = Charts.ChartRepo.all
    render conn, "index.html", charts: charts
  end

  def show(conn, params) do
    chart = Charts.ChartRepo.find(params["id"])
    render conn, "show.html", chart: chart
  end

  def new(conn, params) do
    render conn, "new.html", changeset: %Ecto.Changeset{changes: %{}, model: %Charts.Chart{}}
  end

  def edit(conn, params) do
    chart = Charts.ChartRepo.find(params["id"])
    render conn, "edit.html", changeset: %Ecto.Changeset{changes: %{}, model: chart}
  end

  def update(conn, params) do
    chart = Charts.ChartRepo.find(params["id"])
    changeset  = Charts.Chart.changeset(chart, params)
    if changeset.valid? do
      chart = Charts.ChartRepo.update(chart)
      conn |> put_flash(:notice, "Chart updated!")
      |> redirect to: charts_path(conn, :show, current_user(conn).id, chart.id)
    else
      conn |> put_flash(:error, Charts.Chart.full_error_message(changeset))
      |> render "edit.html", changeset: changeset
    end
  end

  def create(conn, params) do
    changeset  = Charts.Chart.changeset(%Charts.Chart{}, params)
    if changeset.valid? do
      chart = Charts.ChartRepo.create(params["type"], params["title"], current_user(conn).id)
      conn |> put_flash(:notice, "Chart created!")
      |> redirect to: charts_path(conn, :show, current_user(conn).id, chart.id)
    else
      changeset = %{ changeset | model: %Charts.Chart{type: params["type"], title: params["title"]}}
      conn |> put_flash(:error, Charts.Chart.full_error_message(changeset))
      |> render "new.html", changeset: changeset
    end
  end

  def delete(conn, params) do
    chart = Charts.ChartRepo.find(params["id"])
    Charts.Repo.delete(chart)
    conn |> put_flash(:notice, "The chart '#{chart.title}' has been deleted!")
    |> redirect to: charts_path(@conn, :index, current_user(conn).id)
  end


end
