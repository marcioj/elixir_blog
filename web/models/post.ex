defmodule Blog.Post do
  use Blog.Web, :model

  schema "posts" do
    field :title, :string
    field :content, :string

    timestamps
  end

  def destroy(id) do
    Blog.Repo.delete(%Blog.Post{ id: id |> String.to_integer })
  end

  def changeset(post, params \\ nil) do
    post
      |> cast(params, ~w(title content), ~w())
      |> validate_presence(:title, "Title is required")
      |> validate_presence(:content, "Content is required")
  end
end
