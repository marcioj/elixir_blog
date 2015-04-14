defmodule Blog.PostsController do
  use Blog.Web, :controller
  alias Blog.Post

  plug :action

  def index(conn, _params) do
    render conn, "index.html", posts: Repo.all(Post)
  end

  def new(conn, _params) do
    changeset = Post.changeset(%Post{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, params) do
    changeset = Post.changeset %Post{}, params["post"]
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

  def edit(conn, params) do
    post = Repo.get!(Post, params["id"])
    post = Post.changeset(post)
    render conn, "edit.html", changeset: post
  end

  def update(conn, params) do
    changeset = Post.changeset Repo.get!(Post, params["id"]), params["post"]
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

  def delete(conn, params) do
    Post.destroy params["id"]
    conn
      |> put_flash(:notice, "Post deleted!")
      |> redirect to: posts_path(conn, :index)
  end
end
