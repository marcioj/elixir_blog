defmodule Blog.PostsController do
  use Phoenix.Controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html", posts: Post.all
  end

  def new(conn, _params) do
    render conn, "new.html", post: %Post{}
  end

  def create(conn, params) do
    Post.create params
    redirect conn, to: Blog.Router.Helpers.posts_path(conn, :index)
  end

  def edit(conn, params) do
    post = Post.find params["id"]
    render conn, "edit.html", post: post
  end

  def update(conn, params) do
    post = Post.update params
    redirect conn, to: Blog.Router.Helpers.posts_path(conn, :index)
  end
end
