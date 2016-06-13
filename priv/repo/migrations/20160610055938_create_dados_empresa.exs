defmodule PesquisaABMP.Repo.Migrations.CreateDadosEmpresa do
  use Ecto.Migration

  def change do
    create table(:dados_empresas) do
      add :nome, :string
      add :filial, :text
      add :endereco, :text
      add :telefone, :string
      add :site, :string
      add :facebook, :string
      add :twitter, :string
      add :instagram, :string
      add :num_funcionarios, :integer
      add :num_socios, :integer
      add :num_func_homens, :integer
      add :num_func_mulheres, :integer
      add :tempo_atividade, :integer
      add :empresa_id, references(:empresas, on_delete: :nothing)
      add :cidade_id, references(:cidades, on_delete: :nothing)
      add :segmento_id, references(:segmentos, on_delete: :nothing)

      timestamps
    end
    create index(:dados_empresas, [:empresa_id])
    create index(:dados_empresas, [:cidade_id])
    create index(:dados_empresas, [:segmento_id])

  end
end
