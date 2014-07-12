defmodule Blog.Mixfile do
  use Mix.Project

  def project do
    [ app: :blog,
      version: "0.0.1",
      elixir: "~> 0.14.2",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [
      mod: { Blog, [] },
      applications: [:phoenix, :postgrex, :ecto]
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
      {:ecto, "~> 0.2.0"},
      {:phoenix, "0.3.0"},
      {:cowboy, "~> 0.10.0", github: "extend/cowboy", optional: true}
    ]
  end
end
