defmodule PesquisaABMP.Empresa do
  use PesquisaABMP.Web, :model

  schema "empresas" do
    field :nome, :string
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
    belongs_to :cidade, PesquisaABMP.Cidade
    belongs_to :segmento, PesquisaABMP.Segmento

    has_many :empresas_respostas, PesquisaABMP.EmpresaResposta

    timestamps
  end

  @required_fields ~w(nome username cidade_id segmento_id)
  @optional_fields ~w(endereco cep telefone diretor1 diretor2 site email1 email2 password)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:username)
    |> validate_length(:username, min: 1, max: 20)
    |> validate_length(:password, min: 6, max: 100)
    |> put_pass_hash()
  end

  def registration_changeset(model, params) do
    model
    |> changeset(params)
    |> cast(params, ~w(password), [])
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end

end
