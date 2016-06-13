defmodule PesquisaABMP.Repo.Migrations.AddSegmentosQuestionariosRelationship do
  use Ecto.Migration

  def change do
    alter table(:segmentos) do
      add :questionario_id, references(:questionarios)
    end

    create index(:segmentos, [:questionario_id])
  end
end
