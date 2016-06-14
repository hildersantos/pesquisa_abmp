defmodule PesquisaABMP.Repo.Migrations.AddStatusPesquisaToEmpresa do
  use Ecto.Migration

  def change do
    alter table(:empresas) do
      add :status_pesquisa, :string
    end
  end
end
