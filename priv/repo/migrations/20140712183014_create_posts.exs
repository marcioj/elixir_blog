defmodule Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def up do
    """
    CREATE TABLE IF NOT EXISTS post (
      id SERIAL,
      title varchar(255),
      content varchar(255)
    )
    """
  end

  def down do
    "DROP TABLE post"
  end
end
