defmodule Blog.PostsController do
  use Phoenix.Controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html", posts: Post.all
  end

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, params) do
    Post.save params
    redirect conn, to: Blog.Router.Helpers.posts_path(:index)
  end
end
