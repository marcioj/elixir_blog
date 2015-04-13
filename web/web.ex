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
    end
  end

  def model do
    quote do
      use Ecto.Model
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
