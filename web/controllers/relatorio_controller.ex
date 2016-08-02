defmodule PesquisaABMP.RelatorioController do
  use PesquisaABMP.Web, :controller

  # alias PesquisaABMP.Empresa
  alias PesquisaABMP.DadosEmpresa
  # alias PesquisaABMP.EmpresaResposta

  alias PesquisaABMP.QueryFilter

  plug :load_segmentos

  def index(conn, params) do
    dados_empresas = DadosEmpresa
    |> DadosEmpresa.grand_total
    |> apply_filters(params)
    |> Repo.all

    # QueryFilter.filter(%DadosEmpresa{}, dados_empresa_params, [:segmento_id])

    changeset = DadosEmpresa.changeset(%DadosEmpresa{})

    render(conn, "index.html", dados_empresas: dados_empresas, changeset: changeset)
  end

  defp apply_filters(model, params) do
    case params do
      %{"dados_empresa" => %{"segmento_id" => segmento_id} } ->
        model
        |> DadosEmpresa.filter_by_segment(segmento_id)
      _ ->
        model
    end
  end

  defp load_segmentos(conn, _params) do
    query =
      PesquisaABMP.Segmento
      |> PesquisaABMP.Segmento.names_and_ids

    segmentos = Repo.all query
    assign(conn, :segmentos, segmentos)
  end
end
