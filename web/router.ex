defmodule PesquisaABMP.Router do
  use PesquisaABMP.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug PesquisaABMP.Auth, repo: PesquisaABMP.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PesquisaABMP do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/empresas", EmpresaController
    resources "/sessoes", SessaoController, only: [:new, :create, :delete]
    resources "/cidades", CidadeController
    resources "/segmentos", SegmentoController
  end

  # Other scopes may use custom stacks.
  # scope "/api", PesquisaABMP do
  #   pipe_through :api
  # end
end
