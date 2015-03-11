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

end
