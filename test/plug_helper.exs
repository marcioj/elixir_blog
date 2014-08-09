defmodule PlugHelper do

  defmacro __using__(_opts) do
    quote do
      use Plug.Test

      def request(http_method, path) do
        conn = conn(http_method, path)
        Blog.Router.call(conn, [])
      end
    end
  end
end
