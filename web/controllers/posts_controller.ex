defmodule Blog.PostsController do
  use Blog.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html", posts: Repo.all(Post)
  end

  def new(conn, _params) do
    render conn, "new.html", post: %Post{}
  end

  def create(conn, params) do
    changeset = Post.changeset %Post{}, params["post"]
    if changeset.valid? do
      Repo.insert(changeset)
      redirect conn, to: posts_path(conn, :index)
    else
      # TODO
    end
  end

  def edit(conn, params) do
    post = Repo.get!(Post, params["id"])
    render conn, "edit.html", post: post
  end

  def update(conn, params) do
    changeset = Post.changeset Repo.get!(Post, params["id"]), params["post"]
    if changeset.valid? do
      Repo.update(changeset)
      redirect conn, to: posts_path(conn, :index)
    else
      # TODO
    end
  end

  def delete(conn, params) do
    post = Post.destroy params["id"]
    redirect conn, to: posts_path(conn, :index)
  end
end
