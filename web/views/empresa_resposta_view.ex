defmodule PesquisaABMP.EmpresaRespostaView do
  use PesquisaABMP.Web, :view

  def render("index.json", %{empresas_respostas: empresas_respostas}) do
    %{data: render_many(empresas_respostas, __MODULE__, "empresa_resposta.json")}
  end

  def render("empresa_resposta.json", %{empresa_resposta: empresa_resposta}) do
    %{
      id: empresa_resposta.id,
      empresa_id: empresa_resposta.empresa_id,
      resposta_id: empresa_resposta.resposta_id,
      replica: empresa_resposta.replica
    }
  end

end
