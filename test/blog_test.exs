defmodule BlogTest do
  use ExUnit.Case
  use PlugHelper
  use EctoHelper
  import Blog.Router.Helpers
  import Phoenix.Controller
  import Blog.Authenticable, only: [current_user: 1]

  alias Blog.Post
  alias Blog.User
  alias Blog.Repo

  test "PostsController GET index" do
    conn = request(:get, posts_path(Blog.Endpoint, :index))
    assert conn.status == 200
    assert conn.state == :sent
  end

  test "PostsController GET new" do
    conn = request(:get, posts_path(Blog.Endpoint, :new))
    assert conn.status == 200
    assert conn.state == :sent
  end

  test "PostsController POST create" do
    assert Repo.all(Post) == []
    conn = request(:post, posts_path(Blog.Endpoint, :create), %{ post: %{ title: "foo", content: "bar" } })
    assert [%Post{content: "bar", title: "foo"}] = Repo.all(Post)
    assert conn.status == 302
    assert conn.state == :sent
    assert get_flash(conn, :notice) == "Post 'foo' created!"
  end

  test "PostsController GET edit" do
    post = Repo.insert(%Post{ title: "hello", content: "world" })
    conn = request(:get, posts_path(Blog.Endpoint, :edit, post.id))
    assert conn.status == 200
    assert conn.state == :sent
  end

  test "PostsController PUT update" do
    post = Repo.insert(%Post{ title: "hello", content: "world" })
    conn = request(:put, posts_path(Blog.Endpoint, :update, post.id), %{ post: %{ title: "new title", content: "new content" } })
    assert [%Post{title: "new title", content: "new content"}] = Repo.all(Post)
    assert conn.status == 302
    assert conn.state == :sent
    assert get_flash(conn, :notice) == "Post 'new title' updated!"
  end

  test "PostsController DELETE delete" do
    post = Repo.insert(%Post{ title: "hello", content: "world" })
    conn = request(:delete, posts_path(Blog.Endpoint, :delete, post.id))
    assert Repo.all(Post) == []
    assert conn.status == 302
    assert conn.state == :sent
    assert get_flash(conn, :notice) == "Post deleted!"
  end

  test "PagesController GET index" do
    conn = request(:get, page_path(Blog.Endpoint, :index))
    assert conn.status == 302
    assert conn.state == :sent
  end

  test "RegistrationsController GET new" do
    conn = request(:get, registrations_path(Blog.Endpoint, :new))
    assert conn.status == 200
    assert conn.state == :sent
  end

  test "RegistrationsController POST create" do
    assert Repo.all(Post) == []
    conn = request(:post, registrations_path(Blog.Endpoint, :create), %{ user: %{ email: "foo@bar.com", password: "master123", password_confirmation: "master123" } })
    assert [%User{email: "foo@bar.com", encrypted_password: "master123"}] = Repo.all(User)
    assert current_user(conn) == User.last
    assert conn.status == 302
    assert conn.state == :sent
    assert get_flash(conn, :notice) == "Welcome!"
  end

  test "SessionsController GET new" do
    conn = request(:get, sessions_path(Blog.Endpoint, :new))
    assert conn.status == 200
    assert conn.state == :sent
  end

  test "SessionsController POST create" do
    user = Repo.insert(User.changeset(%User{}, %{ email: "foo@bar.com", password: "master123", password_confirmation: "master123" }))
    conn = request(:post, sessions_path(Blog.Endpoint, :create), %{ user: %{ email: "foo@bar.com", password: "wrong" } })
    assert get_flash(conn, :alert) == "Incorrect email or password"

    conn = request(:post, sessions_path(Blog.Endpoint, :create), %{ user: %{ email: "lorem@bar.com", password: "master123" } })
    assert get_flash(conn, :alert) == "Incorrect email or password"

    conn = request(:post, sessions_path(Blog.Endpoint, :create), %{ user: %{ email: "foo@bar.com", password: "master123" } })
    assert get_flash(conn, :notice) == "Welcome!"
    assert current_user(conn).id == user.id
    assert conn.status == 302
    assert conn.state == :sent
  end
end
