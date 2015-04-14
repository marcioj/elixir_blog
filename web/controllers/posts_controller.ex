defmodule Blog.PostsController do
  use Blog.Web, :controller
  alias Blog.Post

  # plug :authenticate, :user when action in [:index]
  plug :action

  # defp authenticate(conn, :user) do
  #   conn |> redirect(to: "/") |> halt
  # end

  def index(conn, _params) do
    render conn, "index.html", posts: Repo.all(Post)
  end

  def new(conn, _params) do
    changeset = Post.changeset(%Post{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{ "post" => post_params }) do
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
    changeset = Post |> Repo.get!(id) |> Post.changeset(post_params)
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
