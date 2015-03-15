defmodule Charts.Mixfile do
  use Mix.Project

  def project do
    [app: :charts,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: ["lib", "web"],
     compilers: [:phoenix] ++ Mix.compilers,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {Charts, []},
     applications: [:phoenix, :cowboy, :logger, :postgrex, :ecto, :httpoison]]
  end

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [{:phoenix, "~> 0.9.0"},
     {:cowboy, "~> 1.0"},
     {:httpoison, "~> 0.6"},
     {:postgrex, ">= 0.0.0"},
     {:ecto, "~> 0.9.0"}]
  end
end
