defmodule PesquisaABMP.Repo.Migrations.AddEmpresaSegmentoCidadeRelationship do
  use Ecto.Migration

  def change do
    alter table(:empresas) do
      add :segmento_id, references(:segmentos)
      add :cidade_id, references(:cidades)
    end
  end
end
