defmodule PesquisaABMP.Repo.Migrations.CreateSegmento do
  use Ecto.Migration

  def change do
    create table(:segmentos) do
      add :nome, :string

      timestamps
    end

  end
end
