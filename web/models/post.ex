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

  def find(id) do
    {id, _} = Integer.parse id
    Repo.get(Post, id)
  end

  def create(params) do
    user = %Post{ content: Map.get(params, "content"), title: Map.get(params, "title") }
    Repo.insert user
  end

  def update(params) do
    {id, _} = Integer.parse params["id"]
    user = %Post{ id: id, content: Map.get(params, "content"), title: Map.get(params, "title") }
    Repo.update user
  end
end
