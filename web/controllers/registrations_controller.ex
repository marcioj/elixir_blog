defmodule Blog.RegistrationsController do
  use Blog.Web, :controller
  alias Blog.User
  alias Blog.Repo
  plug :action

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{ "user" => user_params }) do
    changeset = User.changeset %User{}, user_params
    if changeset.valid? do
      user = Repo.insert(changeset)
      conn
        |> sign_in(user)
        |> put_flash(:notice, "Welcome!")
        |> redirect to: posts_path(conn, :index)
    else
      conn
        |> put_flash(:alert, "Error when creating your user. Please see the errors below.")
        |> render "new.html", changeset: changeset
    end
  end
end
