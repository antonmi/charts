defmodule Charts.ChartsController do
  use Charts.BaseController

  @chart_type "line_chart"

  plug :authenticate
  plug :authorize
  plug :find_chart
  plug :action

  def index(conn, _params) do
    charts = Charts.ChartRepo.all_for_user(current_user(conn))
    render conn, "index.html", charts: charts
  end

  def show(conn, _params) do
    render conn, "show.html", chart: chart(conn), ws_protocol: Charts.API.ChartsController.protocol
  end

  def new(conn, _params) do
    render conn, "new.html", changeset: %Ecto.Changeset{changes: %{}, model: %Charts.Chart{}}
  end

  def edit(conn, _params) do
    render conn, "edit.html", changeset: %Ecto.Changeset{changes: %{}, model: chart(conn)}
  end

  def update(conn, params) do
    changeset  = Charts.Chart.changeset(chart(conn), params)
    if changeset.valid? do
      chart = Charts.Repo.update(chart(conn))
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

  def delete(conn, _params) do
    Charts.Repo.delete(chart(conn))
    conn |> put_flash(:notice, "The chart '#{chart(conn).title}' has been deleted!")
    |> redirect to: charts_path(conn, :index, current_user(conn).id)
  end

  defp find_chart(conn, _opts) do
    if conn.params["id"] do
      chart = Charts.ChartRepo.for_user(current_user(conn), conn.params["id"])
      assign(conn, :chart, chart)
    else
      conn
    end
  end

  defp chart(conn), do: conn.assigns[:chart]

  defp authorize(conn, _opts) do
    user_id = String.to_integer(conn.params["user_id"])
    current_user = current_user(conn)
    if current_user && current_user.id == user_id do
      conn
    else
      Unauthorized
      conn |> put_status(401)
      |> text "401 Unauthorized"
    end
  end


end
