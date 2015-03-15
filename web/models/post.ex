defmodule Post do
  use Blog.Web, :model

  schema "post" do
    field :title, :string
    field :content, :string
  end

  def destroy(id) do
    {id, _} = Integer.parse id
    Repo.delete(%Post{ id: id })
  end

  def changeset(post, params \\ nil) do
    post
      |> cast(params, ~w(), ~w(title content))
  end
end
