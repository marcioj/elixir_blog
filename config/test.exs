use Mix.Config

config :blog, Blog.Endpoint,
  http: [port: System.get_env("PORT") || 4001]
