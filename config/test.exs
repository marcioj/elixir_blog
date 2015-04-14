use Mix.Config

config :blog, Blog.Endpoint,
  http: [port: System.get_env("PORT") || 4001]

config :logger,
  level: :error

config :blog, Blog.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "blog_test",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"
