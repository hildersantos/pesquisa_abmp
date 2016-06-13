defmodule PesquisaABMP.Pergunta do
  use PesquisaABMP.Web, :model

  schema "perguntas" do
    field :tipo, :string
    field :pergunta, :string
    field :observacao, :string

    belongs_to :questionario, PesquisaABMP.Questionario
    has_many :respostas, PesquisaABMP.Resposta, on_delete: :delete_all, on_replace: :delete

    timestamps
  end

  @required_fields ~w(tipo pergunta)
  @optional_fields ~w(questionario_id observacao)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> cast_assoc(:respostas)
  end

  def sorted(query) do
    from p in query,
    order_by: [desc: p.id]
  end
end
