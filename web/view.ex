# defmodule Blog.View do
#
#   defmacro __using__(_options) do
#     quote do
#       use Phoenix.View, templates_root: unquote(Path.join([__DIR__, "templates"]))
#       import unquote(__MODULE__)
#
#       # This block is expanded within all views for aliases, imports, etc
#       alias Blog.Views
#     end
#   end
#
#   # Functions defined here are available to all other views/templates
# end


defmodule Blog.View do
  use Phoenix.View, root: "web/templates"

  # The quoted expression returned by this block is applied
  # to this module and all other views that use this module.
  using do
    quote do
      # Import common functionality
      import Blog.Router.Helpers

      # Use Phoenix.HTML to import all HTML functions (forms, tags, etc)
      use Phoenix.HTML

      # Common aliases
      alias Phoenix.Controller.Flash
    end
  end

  # Functions defined here are available to all other views/templates
end
