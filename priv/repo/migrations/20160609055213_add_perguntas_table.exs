defmodule PesquisaABMP.Repo.Migrations.AddPerguntasTable do
  use Ecto.Migration

  def change do
    create table(:perguntas) do
      add :questionario_id, references(:questionarios, on_delete: :delete_all)
      add :tipo, :string
      add :pergunta, :string

      timestamps
    end

    create index(:perguntas, [:questionario_id])

  end
end
