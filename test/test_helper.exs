ExUnit.start

Mix.Task.run "ecto.create", ~w(-r PesquisaABMP.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r PesquisaABMP.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(PesquisaABMP.Repo)

