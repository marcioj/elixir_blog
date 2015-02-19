use Mix.Config

config :blog, Blog.Endpoint,
  http: [port: System.get_env("PORT") || 4000],
  debug_errors: true

# Enables code reloading for development
config :phoenix, :code_reloader, true

config :blog, Repo,
  database: "blog_dev",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"
