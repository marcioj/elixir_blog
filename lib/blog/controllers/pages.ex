defmodule Blog.Controllers.Pages do
  use Phoenix.Controller

  def index(conn, _params) do
    render conn, "index", message: "hello"
  end
end
