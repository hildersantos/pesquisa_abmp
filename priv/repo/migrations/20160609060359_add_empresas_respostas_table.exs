defmodule PesquisaABMP.Repo.Migrations.AddEmpresasRespostasTable do
  use Ecto.Migration

  def change do
    create table(:empresas_respostas) do
      add :resposta_id, references(:respostas, on_delete: :delete_all)
      add :empresa_id, references(:empresas, on_delete: :delete_all)
      add :replica, :string

      timestamps
    end

    create index(:empresas_respostas, [:resposta_id, :empresa_id])

  end
end
