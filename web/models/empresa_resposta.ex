defmodule PesquisaABMP.EmpresaResposta do
  use PesquisaABMP.Web, :model

  schema "empresas_respostas" do
    field :replica, :string

    belongs_to :resposta, PesquisaABMP.Resposta
    belongs_to :empresa, PesquisaABMP.Empresa

    timestamps
  end

  @required_fields ~w(empresa_id)
  @optional_fields ~w(replica resposta_id)

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
