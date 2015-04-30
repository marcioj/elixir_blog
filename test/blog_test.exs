defmodule BlogTest do
  use ExUnit.Case
  use PlugHelper
  use EctoHelper

  import Blog.Router.Helpers
  import Phoenix.Controller
  import Blog.Authenticable

  alias Blog.Post
  alias Blog.User
  alias Blog.Repo
  alias Blog.Endpoint

  @doc """
  Makes sure that conn is redirected with a flash if there's no user logged in.
  """
  def should_be_authenticated!(%Plug.Conn{} = conn) do
    conn = request(conn)
    assert get_flash(conn, :alert) == "You must be authenticated to proceed"
    assert conn.status == 302
  end

  @doc """
  Makes sure that conn is redirected with a flash if the user is already logged in.
  """
  def should_be_unauthenticated!(%Plug.Conn{} = conn, user \\ create_user) do
    conn = sign_in(conn, user)
    conn = request(conn)
    assert get_flash(conn, :alert) == "You're already logged in"
    assert conn.status == 302
  end

  def create_user do
    Repo.insert(User.changeset(%User{}, %{ email: "foo@bar.com", password: "master123", password_confirmation: "master123" }))
  end

  def create_post(%User{ id: id } \\ create_user) do
    Repo.insert(%Post{ title: "hello", content: "world", author_id: id })
  end

  test "PostsController GET index" do
    conn = request(:get, posts_path(Endpoint, :index))
    assert conn.status == 200
    assert conn.state == :sent
  end

  test "PostsController GET new" do
    conn = create_conn(:get, posts_path(Endpoint, :new))
    should_be_authenticated!(conn)

    conn = sign_in(conn, create_user)
    conn = request(conn)

    assert conn.status == 200
    assert conn.state == :sent
  end

  test "PostsController POST create" do
    conn = create_conn(:post, posts_path(Endpoint, :create), %{ post: %{ title: "foo", content: "bar" } })
    should_be_authenticated!(conn)
    user = %{ id: id } = create_user
    conn = sign_in(conn, user)
    conn = request(conn)

    assert [%Post{content: "bar", title: "foo", author_id: ^id}] = Repo.all(Post)
    assert conn.status == 302
    assert conn.state == :sent
    assert get_flash(conn, :notice) == "Post 'foo' created!"
  end

  test "PostsController GET edit" do
    conn = create_conn(:get, posts_path(Endpoint, :edit, create_post.id))
    should_be_authenticated!(conn)

    conn = sign_in(conn, create_user)
    conn = request(conn)

    assert conn.status == 200
    assert conn.state == :sent
  end

  test "PostsController PUT update" do
    author = create_user
    post = author |> create_post
    conn = create_conn(:put, posts_path(Endpoint, :update, post.id), %{ post: %{ title: "new title", content: "new content" } })
    should_be_authenticated!(conn)

    conn = sign_in(conn, author)
    conn = request(conn)

    assert [%Post{title: "new title", content: "new content"}] = Repo.all(Post)
    assert conn.status == 302
    assert conn.state == :sent
    assert get_flash(conn, :notice) == "Post 'new title' updated!"
  end

  test "Should not allow post update/delete by users other than the author of the post" do
    author = create_user
    other_user = create_user
    post = create_post(author)
    author_only_conns = [
      create_conn(:put, posts_path(Endpoint, :update, post.id), %{ post: %{ title: "new title", content: "new content" } }),
      create_conn(:delete, posts_path(Endpoint, :delete, post.id))
      ]
    for conn <- author_only_conns do
      conn = conn |> sign_in(other_user) |> request()
      assert conn.status == 302
      assert conn.state == :sent
      assert get_flash(conn, :alert) == "This post doesn't belong to you!"
      assert [post] == Repo.all(Post)
    end
  end

  test "PostsController DELETE delete" do
    author = create_user
    conn = create_conn(:delete, posts_path(Endpoint, :delete, create_post(author).id))
    should_be_authenticated!(conn)
    assert Enum.count(Repo.all(Post)) == 1

    conn = sign_in(conn, author) |> request()
    assert Repo.all(Post) == []
    assert conn.status == 302
    assert conn.state == :sent
    assert get_flash(conn, :notice) == "Post deleted!"
  end

  test "PagesController GET index" do
    conn = request(:get, page_path(Endpoint, :index))
    assert conn.status == 302
    assert conn.state == :sent
  end

  test "RegistrationsController GET new" do
    conn = create_conn(:get, registrations_path(Endpoint, :new))
    should_be_unauthenticated!(conn)
    conn = request(conn)

    assert conn.status == 200
    assert conn.state == :sent
  end

  test "RegistrationsController POST create" do
    conn = create_conn(:post, registrations_path(Endpoint, :create), %{ user: %{ email: "foo@bar.com", password: "master123", password_confirmation: "master123" } })
    should_be_unauthenticated!(conn)
    conn = request(conn)

    assert %User{email: "foo@bar.com" } = User.last
    assert current_user(conn) == User.last
    assert conn.status == 302
    assert conn.state == :sent
    assert get_flash(conn, :notice) == "Welcome!"
  end

  test "SessionsController GET new" do
    conn = create_conn(:get, sessions_path(Endpoint, :new))
    should_be_unauthenticated!(conn)
    conn = request(conn)

    assert conn.status == 200
    assert conn.state == :sent
  end

  test "SessionsController POST create" do
    conn = create_conn(:post, sessions_path(Endpoint, :create), %{ user: %{ email: "foo@bar.com", password: "wrong" } })
    user = create_user
    should_be_unauthenticated!(conn, user)
    conn = request(conn)
    assert get_flash(conn, :alert) == "Incorrect email or password"

    conn = request(:post, sessions_path(Endpoint, :create), %{ user: %{ email: "lorem@bar.com", password: "master123" } })
    assert get_flash(conn, :alert) == "Incorrect email or password"

    conn = request(:post, sessions_path(Endpoint, :create), %{ user: %{ email: "foo@bar.com", password: "master123" } })
    assert get_flash(conn, :notice) == "Welcome!"
    assert current_user(conn).id == user.id
    assert conn.status == 302
    assert conn.state == :sent
  end

  test "SessionsController DELETE delete" do
    user = create_user
    conn = create_conn(:delete, sessions_path(Endpoint, :delete))
    conn = sign_in(conn, user)
    assert current_user(conn).id == user.id

    conn = request(conn)
    assert !current_user(conn)
    assert get_flash(conn, :notice) == "See you later"
    assert conn.status == 302
    assert conn.state == :sent
  end
end
