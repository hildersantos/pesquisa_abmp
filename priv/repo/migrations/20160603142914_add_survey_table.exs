defmodule PesquisaABMP.Repo.Migrations.AddSurveyTable do
  use Ecto.Migration

  def change do
    create table(:questionarios) do
      add :name, :string

      timestamps
    end
  end
end
