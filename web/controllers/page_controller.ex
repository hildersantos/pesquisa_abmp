defmodule PesquisaABMP.PageController do
  use PesquisaABMP.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def final(conn, _params) do
    render conn, "final.html"
  end
end
