defmodule Repo do
  use Ecto.Repo, adapter: Ecto.Adapters.Postgres, env: Mix.env

  def conf(env), do: parse_url url(env)

  defp url(:dev),  do: "ecto://postgres:postgres@localhost/blog_dev"
  defp url(:test), do: "ecto://postgres:postgres@localhost/blog_test?size=1"
  defp url(:prod), do: "ecto://postgres:postgres@localhost/blog_prod"

  def priv do
    app_dir(:blog, "priv/repo")
  end
end
