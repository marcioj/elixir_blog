defmodule Blog.User do
  use Blog.Web, :model
  use Ecto.Model.Callbacks
  import Ecto.Query

  before_insert :encrypt_password

  def encrypt_password(changeset) do
    encrypted_password = Comeonin.Bcrypt.hashpwsalt(changeset.changes.password )
    change(changeset, %{ encrypted_password: encrypted_password })
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

  def authenticate(%{ "email" => email, "password" => password }) do
    query = from user in Blog.User, where: user.email == ^email
    user = Blog.Repo.one query
    if user && Comeonin.Bcrypt.checkpw(password, user.encrypted_password) do
      user
    end
  end

  def last do
    query = from user in Blog.User, order_by: [desc: user.id], limit: 1
    Blog.Repo.one query
  end
end
