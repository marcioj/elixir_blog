defmodule Blog.Post do
  use Blog.Web, :model

  schema "posts" do
    field :title, :string
    field :content, :string

    timestamps
  end

  def destroy(id) do
    Repo.delete(%Blog.Post{ id: id |> String.to_integer })
  end

  def changeset(post, params \\ nil) do
    post
      |> cast(params, ~w(title content), ~w())
      |> validate_presence(:title, "Title is required")
      |> validate_presence(:content, "Content is required")
  end

  defp validate_presence(changeset, field, message \\ :presence) do
    validate_change changeset, field, fn _, value ->
      if present?(value) do
        []
      else
        [{field, message}]
      end
    end
  end

  defp present?(obj) when obj in [nil, ""] do
    false
  end

  defp present?(str) when is_bitstring(str)  do
    str |> String.strip |> String.length > 0
  end
end
