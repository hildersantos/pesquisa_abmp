defmodule PesquisaABMP.Repo.Migrations.CreateEmpresa do
  use Ecto.Migration

  def change do
    create table(:empresas) do
      add :endereco, :string
      add :cep, :string
      add :telefone, :string
      add :diretor1, :string
      add :diretor2, :string
      add :site, :string
      add :email1, :string
      add :email2, :string
      add :username, :string, null: false
      add :password_hash, :string

      timestamps
    end

    create unique_index(:empresas, [:username])
  end
end
