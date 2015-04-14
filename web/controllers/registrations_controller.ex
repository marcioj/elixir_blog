defmodule Blog.RegistrationsController do
  use Blog.Web, :controller
  alias Blog.User
  plug :action

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, "new.html", changeset: changeset
  end
end
