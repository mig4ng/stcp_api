defmodule StopsAPI.MixProject do
  use Mix.Project

  def project do
    [
      app: :stops_api,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {StopsAPI.Application, []}
    ]
  end

  defp deps do
    [
      {:plug_cowboy, "~> 2.5"},
      {:httpoison, "~> 2.0"},
      {:floki, "~> 0.34"},
      {:jason, "~> 1.4"}
    ]
  end
end
