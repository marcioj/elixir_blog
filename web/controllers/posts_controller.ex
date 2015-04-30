defmodule Blog.PostsController do
  use Blog.Web, :controller
  alias Blog.Post
  alias Blog.Repo

  plug :authenticate, :user when action in [:new, :create, :edit, :update, :delete]
  plug :action

  def index(conn, _params) do
    render conn, "index.html", posts: Repo.all(Post)
  end

  def new(conn, _params) do
    changeset = Post.changeset(%Post{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{ "post" => post_params }) do
    post_params = Dict.put(post_params, "author_id", current_user_id(conn))
    changeset = Post.changeset %Post{}, post_params
    if changeset.valid? do
      post = Repo.insert(changeset)
      conn
        |> put_flash(:notice, "Post '#{post.title}' created!")
        |> redirect to: posts_path(conn, :index)
    else
      conn
        |> put_flash(:alert, "Error when creating a post. Please see the errors below.")
        |> render "new.html", changeset: changeset
    end
  end

  def edit(conn, %{ "id" => id }) do
    post = Post |> Repo.get!(id) |> Post.changeset
    render conn, "edit.html", changeset: post
  end

  def update(conn, %{ "id" => id, "post" => post_params }) do
    post = Post |> Repo.get!(id)
    if post.author_id == current_user_id(conn) do
      update_post(conn, post, sanitize_params(post_params))
    else
      conn
        |> put_flash(:alert, "This post doesn't belong to you!")
        |> redirect to: posts_path(conn, :index)
    end
  end

  defp sanitize_params(post_params) do
    Dict.delete(post_params, "author_id") # author_id should NEVER come from the user
  end

  defp update_post(conn, post = %Post{}, post_params ) do
    changeset = post |> Post.changeset(post_params)
    if changeset.valid? do
      post = Repo.update(changeset)
      conn
        |> put_flash(:notice, "Post '#{post.title}' updated!")
        |> redirect to: posts_path(conn, :index)
    else
      conn
        |> put_flash(:alert, "Error when updating a post. Please see the errors below.")
        |> render "edit.html", changeset: changeset
    end
  end

  def delete(conn, %{ "id" => id }) do
    Post.destroy(id)
    conn
      |> put_flash(:notice, "Post deleted!")
      |> redirect to: posts_path(conn, :index)
  end
end
