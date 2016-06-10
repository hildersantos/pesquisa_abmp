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
    plug :fetch_session
    plug :fetch_flash
    plug PesquisaABMP.Auth, repo: PesquisaABMP.Repo
  end

  scope "/", PesquisaABMP do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/pesquisa", PesquisaController, :index
    resources "/empresas", EmpresaController
    resources "/sessoes", SessaoController, only: [:new, :create, :delete]
    resources "/cidades", CidadeController
    resources "/segmentos", SegmentoController
    resources "/questionarios", QuestionarioController, only: [:new, :edit]
    resources "/dados_empresas", DadosEmpresaController
  end

  # Other scopes may use custom stacks.
  scope "/api", PesquisaABMP, as: :api do
    pipe_through :api

    resources "/questionarios", QuestionarioController, except: [:new, :edit]
    get "/empresas/:id/questionario", QuestionarioController, :questionario_empresa
  end
end
