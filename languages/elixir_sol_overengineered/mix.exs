defmodule Unscramble.MixProject do
  use Mix.Project

  def project do
    [
      app: :unscramble,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: escript()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:persistent_ets, "~> 0.1.0"}
    ]
  end

  def escript do
    [main_module: Unscramble.CLI]
  end
end
