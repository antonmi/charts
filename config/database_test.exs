use Mix.Config

config :charts, Charts.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "charts_test",
  username: "postgres",
  password: "123456"
