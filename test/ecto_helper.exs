defmodule EctoHelper do
  use ExUnit.CaseTemplate
  alias Ecto.Adapters.SQL

  setup do
    :ok = SQL.begin_test_transaction(Repo, [])

    on_exit fn ->
      :ok = SQL.rollback_test_transaction(Repo, [])
    end

    :ok
  end
end
