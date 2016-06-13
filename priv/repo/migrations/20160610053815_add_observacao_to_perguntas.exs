defmodule PesquisaABMP.Repo.Migrations.AddObservacaoToPerguntas do
  use Ecto.Migration

  def change do
    alter table(:perguntas) do
      add :observacao, :text
    end
  end
end
