defmodule BlogTest do
  use ExUnit.Case
  use PlugHelper
  use EctoHelper
  import Blog.Router.Helpers

  test "GET index" do
    conn = request(:get, posts_path(nil, :index))
    assert conn.status == 200
    assert conn.state == :sent
  end

  test "GET new" do
    conn = request(:get, posts_path(nil, :new))
    assert conn.status == 200
    assert conn.state == :sent
  end

  test "POST create" do
    conn = request(:post, posts_path(nil, :create))
    assert conn.status == 302
    assert conn.state == :sent
  end

  test "GET edit" do
    post = Post.create(%{ title: "hello", content: "world" })
    conn = request(:get, posts_path(nil, :edit, post.id))
    assert conn.status == 200
    assert conn.state == :sent
  end

  test "PUT update" do
    post = Post.create(%{ title: "hello", content: "world" })
    conn = request(:put, posts_path(nil, :update, post.id))
    assert conn.status == 302
    assert conn.state == :sent
  end
end
