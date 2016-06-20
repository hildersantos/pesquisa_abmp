defmodule PesquisaABMP.TipoEmpresa do
  use PesquisaABMP.Web, :model

  schema "tipos_empresas" do
    field :nome, :string
    has_many :empresas, PesquisaABMP.Empresa

    timestamps
  end

  @required_fields ~w(nome)
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

  def alphabetical(query) do
    from t in query, order_by: t.nome
  end

  def names_and_ids(query) do
    from t in query, select: {t.nome, t.id}
  end
end
