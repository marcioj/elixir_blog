defmodule BlogTest do
  use ExUnit.Case
  use PlugHelper
  use EctoHelper

  test "GET index" do
    conn = request(:get, "/posts")
    assert conn.status == 200
    assert conn.state == :sent
  end

  test "GET new" do
    conn = request(:get, "/posts/new")
    assert conn.status == 200
    assert conn.state == :sent
  end

  test "POST create" do
    conn = request(:post, "/posts")
    assert conn.status == 302
    assert conn.state == :sent
  end
end
