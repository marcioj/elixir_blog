defmodule Blog.PagesController do
  use Blog.Web, :controller

  plug :action

  def index(conn, _params) do
    redirect conn, to: Blog.Router.Helpers.posts_path(conn, :index)
  end
end
