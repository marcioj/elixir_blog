defmodule Blog.Endpoint do
  use Phoenix.Endpoint, otp_app: :blog

  plug Plug.Static,
    at: "/", from: :blog,
    only: ~w(css images js favicon.ico robots.txt)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_blog_key",
    signing_salt: "aTE5sOL7",
    encryption_salt: "0Xvf1U1i"

  plug :router, Blog.Router
end
