use Mix.Config

config :blog, Blog.Endpoint,
  http: [port: System.get_env("PORT") || 4001]

config :logger,
  level: :error

config :blog, Repo,
  database: "blog_test",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"
