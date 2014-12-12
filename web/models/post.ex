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
