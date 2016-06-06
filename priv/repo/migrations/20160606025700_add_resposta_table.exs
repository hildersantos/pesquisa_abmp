defmodule PesquisaABMP.Repo.Migrations.AddRespostaTable do
  use Ecto.Migration

  def change do
    create table(:respostas) do
      add :pergunta_id, references(:perguntas, on_delete: :delete_all)
      add :resposta, :string

      timestamps
    end

    create index(:respostas, [:pergunta_id])
  end
end
