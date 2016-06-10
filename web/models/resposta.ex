defmodule PesquisaABMP.Resposta do
  use PesquisaABMP.Web, :model

  schema "respostas" do
    field :resposta, :string

    belongs_to :pergunta, PesquisaABMP.Pergunta
    has_many :empresas_respostas, PesquisaABMP.EmpresaResposta, on_delete: :delete_all, on_replace: :delete

    timestamps
  end

  @required_fields ~w(resposta)
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
