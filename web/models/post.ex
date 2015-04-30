defmodule Blog.Post do
  use Blog.Web, :model

  schema "posts" do
    field :title, :string
    field :content, :string
    belongs_to :author, Blog.User

    timestamps
  end

  def destroy(id) do
    Blog.Repo.delete(%Blog.Post{ id: id |> String.to_integer })
  end

  def changeset(post, params \\ nil) do
    post
      |> cast(params, ~w(title content author_id), ~w())
      |> validate_presence(:title, "Title is required")
      |> validate_presence(:content, "Content is required")
      |> validate_presence(:author, "Author is required")
  end
end
