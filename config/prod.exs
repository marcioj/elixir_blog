use Mix.Config

# ## SSL Support
#
# To get SSL working, you will need to set:
#
#     https: [port: 443,
#             keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#             certfile: System.get_env("SOME_APP_SSL_CERT_PATH")]
#
# Where those two env variables point to a file on
# disk for the key and cert.

config :blog, Blog.Endpoint,
  url: [host: "example.com"],
  http: [port: System.get_env("PORT")],
  secret_key_base: "wuSIkKk88wffd3ZiT0FuDn90jsYaTZ1rXSMGhTofC184TK/zm5OdFqXrbgi+gPO7"

config :logger,
  level: :info

config :blog, Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "blog_prod",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"
