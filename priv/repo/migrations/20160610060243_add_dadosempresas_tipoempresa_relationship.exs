defmodule PesquisaABMP.Repo.Migrations.AddDadosempresasTipoempresaRelationship do
  use Ecto.Migration

  def change do
    alter table(:dados_empresas) do
      add :tipo_empresa_id, references(:tipos_empresas, on_delete: :nothing)
    end

    create index(:dados_empresas, [:tipo_empresa_id])
  end
end
