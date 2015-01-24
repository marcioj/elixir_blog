defmodule Blog do
  use Application

  # See http://elixir-lang.org/docs/stable/Application.Behaviour.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec
    tree = [worker(Repo, []), worker(Blog.Endpoint, [])]
    opts = [name: Blog.Supervisor, strategy: :one_for_one]
    Supervisor.start_link(tree, opts)
  end

  def config_change(changed, _new, removed) do
    Blog.Endpoint.config_change(changed, removed)
    :ok
  end
end

