defmodule PesquisaABMP.Repo.Migrations.CreateQuestionario do
  use Ecto.Migration

  def change do
    create table(:questionarios) do
      add :nome, :string

      timestamps
    end

  end
end
