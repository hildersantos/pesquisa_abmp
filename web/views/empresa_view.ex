defmodule PesquisaABMP.EmpresaView do
  use PesquisaABMP.Web, :view

  def cidades do
    PesquisaABMP.Repo.all(PesquisaABMP.Cidade) |> Enum.map(&{&1.nome,&1.id})
  end

  def segmentos do
    PesquisaABMP.Repo.all(PesquisaABMP.Segmento) |> Enum.map(&{&1.nome,&1.id})
  end

end
