defmodule Blog.Endpoint do
  use Phoenix.Endpoint, otp_app: :blog

  plug Plug.Static,
    at: "/", from: :blog

  plug Plug.Logger

  # Code reloading will only work if the :code_reloader key of
  # the :phoenix application is set to true in your config file.
  plug Phoenix.CodeReloader

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
