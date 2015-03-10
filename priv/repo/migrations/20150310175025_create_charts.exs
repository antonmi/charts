defmodule Charts.Repo.Migrations.CreateCharts do
  use Ecto.Migration

  def up do
    create table :charts do
      add :type, :string
      add :user_id, :integer
      add :data, :text
    end
  end

  def down do
    drop table :charts
  end
end
