defmodule Blog.SessionsController do
  use Blog.Web, :controller
  alias Blog.User
  alias Blog.Repo
  plug :action

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{ "user" => user_params }) do
    user = User.authenticate user_params
    if user do
      conn
        |> sign_in(user)
        |> put_flash(:notice, "Welcome!")
        |> redirect to: posts_path(conn, :index)
    else
      conn
        |> put_flash(:alert, "Incorrect email or password")
        |> render "new.html", changeset: User.changeset(%User{}, user_params |> Map.delete("password"))
    end
  end

end
