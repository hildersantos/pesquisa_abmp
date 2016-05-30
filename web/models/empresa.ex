defmodule PesquisaABMP.Empresa do
  use PesquisaABMP.Web, :model

  schema "empresas" do
    field :endereco, :string
    field :cep, :string
    field :telefone, :string
    field :diretor1, :string
    field :diretor2, :string
    field :site, :string
    field :email1, :string
    field :email2, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps
  end

  @required_fields ~w(endereco cep telefone diretor1 diretor2 site email1 email2 username)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
