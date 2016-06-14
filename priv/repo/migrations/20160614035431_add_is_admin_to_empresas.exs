defmodule PesquisaABMP.Repo.Migrations.AddIsAdminToEmpresas do
  use Ecto.Migration

  def change do
    alter table(:empresas) do
      add :is_admin, :boolean
    end
  end
end
