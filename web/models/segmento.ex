defmodule PesquisaABMP.Segmento do
  use PesquisaABMP.Web, :model

  schema "segmentos" do
    field :nome, :string

    belongs_to :questionario, PesquisaABMP.Questionario
    has_many :empresas, PesquisaABMP.Empresa

    timestamps
  end

  @required_fields ~w(nome)
  @optional_fields ~w(questionario_id)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def names_and_ids(query) do
    from t in query, select: {t.nome, t.id}
  end
end
