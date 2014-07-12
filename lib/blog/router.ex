defmodule Blog.Router do
  use Phoenix.Router

  plug Plug.Static, at: "/static", from: :blog
  resources "posts", Blog.Controllers.Posts
  get "/", Blog.Controllers.Pages, :index, as: :page
end
