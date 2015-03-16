# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

IO.puts System.get_env("PORT")
# Configures the endpoint
config :charts, Charts.Endpoint,
  url: [host: "localhost"],
  port: System.get_env("PORT") || 4000,
  secret_key_base: "DLcWxJfWlmFdUwSBB34mCKcUuux7PDRj7BnhO0p52Kb1XTAAfkuhiZjp5lLwMjPW",
  debug_errors: false,
  pubsub: [adapter: Phoenix.PubSub.PG2]


# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# config :charts, Charts.Repo,
#   adapter: Ecto.Adapters.Postgres,
#   database: "charts_dev",
#   username: "postgres",
#   password: "123456"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
