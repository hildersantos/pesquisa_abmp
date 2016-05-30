defmodule PesquisaABMP.PageController do
  use PesquisaABMP.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
