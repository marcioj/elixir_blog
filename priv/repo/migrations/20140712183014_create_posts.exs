defmodule Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def up do
    """
    CREATE TABLE IF NOT EXISTS post (
      id SERIAL,
      title varchar(255),
      content text
    )
    """
  end

  def down do
    "DROP TABLE post"
  end
end
