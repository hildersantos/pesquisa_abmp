defmodule PesquisaABMP.Repo.Migrations.AddEmpresaRespostaRelationship do
  use Ecto.Migration

  def change do
    create table(:empresas_respostas) do
      add :resposta_id, references(:respostas)
      add :empresa_id, references(:empresas)
      add :replica, :string

      timestamps
    end

    create index(:empresas_respostas, [:resposta_id, :empresa_id])
  end
end
