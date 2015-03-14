defmodule Charts.Chart do
  use Charts.BaseModel
  alias Charts.ChartRepo

  @types [
    line_chart: "Line Chart",
    area_chart: "Area Chart"
  ]

  schema "charts" do
    field :type, :string
    field :user_id, :integer
    field :data, :binary, default: "{}"
    field :title, :string
  end

  def types(), do: @types

  def changeset(chart, params) do
    set = chart |> cast(params, ~w(type title), ~w()) |> validate_length(:title, min: 1)
    unless Keyword.keys(@types) |> Enum.member?(String.to_atom(params["type"])) do
      errors = [{:type, :not_in_list} | set.errors]
      set = %{set | valid?: false, errors: errors }
    end
    set
  end


  def error_message({:type, :not_in_list}), do: "Select type!"
  def error_message({:title, {:too_short, 1}}), do: "Missing title!"
  def error_message(_), do: "Some error"


end
