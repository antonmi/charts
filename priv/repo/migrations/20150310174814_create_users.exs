defmodule Charts.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def up do
    create table :users do
      add :username, :string
      add :passhash, :string
    end
  end

  def down do
    drop table :users
  end
end
