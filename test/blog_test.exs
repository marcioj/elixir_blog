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
    assert Post.all == []
    conn = request(:post, posts_path(nil, :create), title: "foo", content: "bar")
    assert [%Post{content: "bar", title: "foo"}] = Post.all
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
    conn = request(:put, posts_path(nil, :update, post.id), title: "new title", content: "new content")
    assert [%Post{title: "new title", content: "new content"}] = Post.all
    assert conn.status == 302
    assert conn.state == :sent
  end

  test "DELETE destroy" do
    post = Post.create(%{ title: "hello", content: "world" })
    conn = request(:delete, posts_path(nil, :destroy, post.id))
    assert Post.all == []
    assert conn.status == 302
    assert conn.state == :sent
  end
end
