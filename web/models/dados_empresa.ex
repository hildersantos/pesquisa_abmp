defmodule PesquisaABMP.DadosEmpresa do
  use PesquisaABMP.Web, :model

  schema "dados_empresas" do
    field :nome, :string
    field :filial, :string
    field :endereco, :string
    field :telefone, :string
    field :site, :string
    field :facebook, :string
    field :twitter, :string
    field :instagram, :string
    field :num_funcionarios, :integer
    field :num_socios, :integer
    field :num_func_homens, :integer
    field :num_func_mulheres, :integer
    field :tempo_atividade, :integer
    belongs_to :empresa, PesquisaABMP.Empresa
    belongs_to :cidade, PesquisaABMP.Cidade
    belongs_to :segmento, PesquisaABMP.Segmento

    timestamps
  end

  @required_fields ~w(nome endereco telefone num_funcionarios num_socios num_func_homens num_func_mulheres tempo_atividade)
  @optional_fields ~w(filial site facebook twitter instagram)

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
