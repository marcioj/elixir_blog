defmodule Blog.Authenticable do
  import Plug.Conn

  def current_user(conn) do
    id = get_session(conn, :user_id)
    if id do
      Blog.User |> Blog.Repo.get(id)
    end
  end

  def sign_in(conn, %{ id: id }) do
    put_session(conn, :user_id, id)
  end
end
