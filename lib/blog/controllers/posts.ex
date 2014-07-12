defmodule Blog.Controllers.Posts do
  use Phoenix.Controller
  require IEx

  def index(conn, _params) do
    render conn, "index", posts: Post.all
  end

  def new(conn, _params) do
    render conn, "new"
  end

  def create(conn, params) do
    Post.save params
    redirect conn, Blog.Router.posts_path
  end
end
