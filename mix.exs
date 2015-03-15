defmodule Blog.Mixfile do
  use Mix.Project

  def project do
    [ app: :blog,
      version: "0.0.1",
      elixir: "1.0.2",
      elixirc_paths: ["lib", "web"],
      compilers: [:phoenix] ++ Mix.compilers,
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
      {:phoenix, "~> 0.10.0"},
      {:phoenix_ecto, "~> 0.1.0"},
      {:cowboy, "~> 1.0"}
    ]
  end
end
