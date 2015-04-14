defmodule Blog.Authenticable do
  import Plug.Conn
  import Phoenix.Controller

  def current_user(conn) do
    id = get_session(conn, :user_id)
    if id do
      Blog.User |> Blog.Repo.get(id)
    end
  end

  def sign_out_user(conn, %{ id: id }) do
    delete_session(conn, :user_id)
  end

  def sign_in(conn, %{ id: id }) do
    put_session(conn, :user_id, id)
  end

  def authenticate(conn, :user) do
    unless current_user(conn) do
      conn
      |> put_flash(:alert, "You must be authenticated to proceed")
      |> redirect(to: "/")
      |> halt
    else
      conn
    end
  end

  def unauthenticate(conn, :user) do
    if current_user(conn) do
      conn
      |> put_flash(:alert, "You're already logged in")
      |> redirect(to: "/")
      |> halt
    else
      conn
    end
  end
end
