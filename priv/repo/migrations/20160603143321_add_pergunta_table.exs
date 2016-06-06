defmodule PesquisaABMP.Repo.Migrations.AddPerguntaTable do
  use Ecto.Migration

  def change do
    create table(:perguntas) do
      add :tipo, :string
      add :pergunta, :string
      add :questionario_id, references(:questionarios, on_delete: :delete_all)

      timestamps
    end

    create index(:perguntas, [:questionario_id])
  end
end
