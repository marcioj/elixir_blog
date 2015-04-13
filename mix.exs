defmodule Blog.Mixfile do
  use Mix.Project

  def project do
    [ app: :blog,
      version: "0.0.1",
      elixir: "~> 1.0",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix] ++ Mix.compilers,
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [
      mod: { Blog, [] },
      applications: [:phoenix, :phoenix_ecto, :cowboy, :logger, :postgrex]
    ]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, git: "https://github.com/elixir-lang/foobar.git", tag: "0.1" }
  #
  # To specify particular versions, regardless of the tag, do:
  # { :barbat, "~> 0.1", github: "elixir-lang/barbat" }
  defp deps do
    [
      {:postgrex, ">= 0.0.0"},
      {:phoenix, "~> 0.11.0"},
      {:phoenix_ecto, "~> 0.1.0"},
      {:phoenix_live_reload, "~> 0.3"},
      {:cowboy, "~> 1.0"}
    ]
  end

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]
end
