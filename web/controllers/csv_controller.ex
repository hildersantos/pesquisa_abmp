defmodule PesquisaABMP.CsvController do
  use PesquisaABMP.Web, :controller
  alias PesquisaABMP.Segmento

  def export(conn, %{"segmento_id" => segmento_id}) do
    empresas = Repo.all(
      from s in Segmento,
      join: e in assoc(s, :empresas),
      where: e.segmento_id == ^segmento_id and not is_nil(e.email1),
      select: [e.nome, e.email1, e.username],
      order_by: [asc: e.nome]
    )

    # Renderizando o CSV com os dados
    conn
    |> put_resp_content_type("text/csv")
    |> put_resp_header("Content-Disposition", "attachment; filename=\"segmento_"<> segmento_id <>".csv")
    |> send_resp(200, conteudo_csv([["Nome", "Email", "Usuario"]] ++ empresas))
  end

  defp conteudo_csv(content) do
    content
    |> CSV.encode()
    |> Enum.to_list()
    |> to_string()
  end


end
