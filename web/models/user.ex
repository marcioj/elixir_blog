defmodule Blog.User do
  use Blog.Web, :model
  use Ecto.Model.Callbacks
  import Ecto.Query

  before_insert :encrypt_password

  def encrypt_password(changeset) do
    change(changeset, %{ encrypted_password: changeset.changes.password })
  end

  schema "users" do
    field :name, :string
    field :email, :string
    field :encrypted_password, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps
  end

  @required_fields ~w(email)
  @optional_fields ~w(name password password_confirmation encrypted_password)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ nil) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_confirmation(:password, "Password doesn't match")
    |> validate_presence(:email, "Email is required")
    |> validate_presence(:password, "Password is required")
    |> validate_presence(:password_confirmation, "Password confirmation is required")
  end

  def last do
    query = from user in Blog.User, order_by: [desc: user.id], limit: 1
    Repo.one query
  end
end
