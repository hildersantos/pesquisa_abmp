defmodule PesquisaABMP.Repo.Migrations.CreateCidade do
  use Ecto.Migration

  def change do
    create table(:cidades) do
      add :nome, :string

      timestamps
    end

  end
end
