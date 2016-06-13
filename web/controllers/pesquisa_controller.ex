defmodule PesquisaABMP.PesquisaController do
  use PesquisaABMP.Web, :controller

  def index(conn, _params, empresa) do
    render conn, "index.html", empresa: empresa
  end

  def action(conn, _) do
    apply(__MODULE__, action_name(conn), [conn, conn.params, conn.assigns.current_user])
  end
end
