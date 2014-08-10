defmodule Blog do
  use Application

  # See http://elixir-lang.org/docs/stable/Application.Behaviour.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec
    tree = [worker(Repo, [])]
    opts = [name: Blog.Supervisor, strategy: :one_for_one]
    Supervisor.start_link(tree, opts)
  end
end

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

defmodule Post do
  use Ecto.Model

  schema "post" do
    field :title, :string
    field :content, :string
  end

  def all do
    query = from w in __MODULE__,
    select: w
    Repo.all(query)
  end

  def save(params) do
    user = %Post{ content: Map.get(params, "content"), title: Map.get(params, "title") }
    Repo.insert user
  end
end
