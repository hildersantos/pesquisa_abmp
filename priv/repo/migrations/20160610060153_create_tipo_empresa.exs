defmodule PesquisaABMP.Repo.Migrations.CreateTipoEmpresa do
  use Ecto.Migration

  def change do
    create table(:tipos_empresas) do
      add :nome, :string

      timestamps
    end

  end
end
