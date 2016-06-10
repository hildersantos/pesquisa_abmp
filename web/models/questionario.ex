defmodule PesquisaABMP.Questionario do
  use PesquisaABMP.Web, :model

  schema "questionarios" do
    field :nome, :string
    has_many :segmentos, PesquisaABMP.Segmento
    has_many :perguntas, PesquisaABMP.Pergunta, on_delete: :delete_all, on_replace: :delete

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
    |> cast_assoc(:perguntas)
  end
end
