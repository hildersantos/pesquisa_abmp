defmodule PesquisaABMP.DadosEmpresaView do
  use PesquisaABMP.Web, :view
  require Ecto.Query

  def cidades do
    PesquisaABMP.Repo.all(Ecto.Query.from(c in PesquisaABMP.Cidade, order_by: [asc: c.nome])) |> Enum.map(&{&1.nome,&1.id})
  end

  def segmentos do
    PesquisaABMP.Repo.all(Ecto.Query.from(s in PesquisaABMP.Segmento, order_by: [asc: s.nome])) |> Enum.map(&{&1.nome,&1.id})
  end
end
