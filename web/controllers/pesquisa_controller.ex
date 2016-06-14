defmodule PesquisaABMP.PesquisaController do
  use PesquisaABMP.Web, :controller

  def index(conn, _params, empresa) do
    if(empresa.status_pesquisa !== "iniciada" && empresa.status_pesquisa !== "concluida") do
      conn
      |> put_flash(:error, "Você precisa preencher estes dados primeiro")
      |> redirect(to: dados_empresa_path(conn, :new))
      |> halt()
    end

    if(empresa.status_pesquisa === "concluida") do
      conn
      |> put_flash(:info, "Sua pesquisa já foi respondida. Obrigado!")
      |> redirect(to: page_path(conn, :final))
      |> halt()
    end

    render conn, "index.html", empresa: empresa
  end

  def action(conn, _) do
    apply(__MODULE__, action_name(conn), [conn, conn.params, conn.assigns.current_user])
  end
end
