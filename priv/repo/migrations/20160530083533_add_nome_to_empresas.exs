defmodule PesquisaABMP.Repo.Migrations.AddNomeToEmpresas do
  use Ecto.Migration

  def change do
    alter table(:empresas) do
      add :nome, :string
    end
  end
end
