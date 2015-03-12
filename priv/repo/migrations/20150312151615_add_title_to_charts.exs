defmodule Charts.Repo.Migrations.AddTitleToCharts do
  use Ecto.Migration

  def change do
    alter table(:charts) do
      add :title, :string
    end
  end
end
