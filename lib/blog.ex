defmodule Blog do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Start the endpoint when the application starts
      supervisor(Blog.Endpoint, []),
      # Start the Ecto repository
      worker(Blog.Repo, [])
    ]

    opts = [name: Blog.Supervisor, strategy: :one_for_one]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    Blog.Endpoint.config_change(changed, removed)
    :ok
  end
end

