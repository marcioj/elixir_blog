defmodule EctoHelper do
  use ExUnit.CaseTemplate
  alias Ecto.Adapters.Postgres

  setup do
    :ok = Postgres.begin_test_transaction(Repo, [])

    on_exit fn ->
      :ok = Postgres.rollback_test_transaction(Repo, [])
    end

    :ok
  end
end
