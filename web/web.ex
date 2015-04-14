defmodule Blog.Web do
  @moduledoc """
  A module that keeps using definitions for controllers,
  views and so on.

  This can be used in your application as:

      use Blog.Web, :controller
      use Blog.Web, :view

  Keep the definitions in this module short and clean,
  mostly focused on imports, uses and aliases.
  """

  def view do
    quote do
      use Phoenix.View, root: "web/templates"

      # Import URL helpers from the router
      import Blog.Router.Helpers

      import Phoenix.Controller, only: [get_flash: 2, get_csrf_token: 0]

      # Import all HTML functions (forms, tags, etc)
      use Phoenix.HTML

      import Ecto.Changeset, only: [get_field: 2]

      import Blog.Authenticable

      def error_for_field(%Ecto.Changeset{errors: errors} = changeset, field) do
        errors[field]
      end
    end
  end

  def controller do
    quote do
      use Phoenix.Controller

      # Import URL helpers from the router
      import Blog.Router.Helpers

      import Blog.Authenticable
    end
  end

  def model do
    quote do
      use Ecto.Model

      defp validate_presence(changeset, field, message \\ :presence) do
        validate_change changeset, field, fn _, value ->
          if present?(value) do
            []
          else
            [{field, message}]
          end
        end
      end

      defp present?(obj) when obj in [nil, ""] do
        false
      end

      defp present?(str) when is_bitstring(str)  do
        str |> String.strip |> String.length > 0
      end

      defp validate_confirmation(changeset, field, message \\ :confirmation) do
        validate_change changeset, field, fn a, value ->
          confirmation_field = String.to_atom(Atom.to_string(field) <> "_confirmation")
          confirmation = Map.get(changeset.changes, confirmation_field)
          if value == confirmation do
            []
          else
            [{confirmation_field, message}]
          end
        end
      end

    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
