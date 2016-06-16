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
    get "/final", PageController, :final
    get "/pesquisa", PesquisaController, :index
    resources "/pre_cadastro", DadosEmpresaController, only: [:new, :create, :delete]
    resources "/empresas", EmpresaController
    resources "/sessoes", SessaoController, only: [:new, :create, :delete]
    get "/sessoes/reset_password", SessaoController, :reset_password
    post "/sessoes/reset_password", SessaoController, :reset_password_handler
    resources "/cidades", CidadeController
    resources "/segmentos", SegmentoController
    resources "/questionarios", QuestionarioController, only: [:new, :edit]
  end

  scope "/csv", PesquisaABMP do
    pipe_through :api

    get "/export/:segmento_id", CsvController, :export
  end

  # Other scopes may use custom stacks.
  scope "/api", PesquisaABMP, as: :api do
    pipe_through :api

    resources "/questionarios", QuestionarioController, except: [:new, :edit]
    resources "/empresas_respostas", EmpresaRespostaController, except: [:new, :edit]
    post "/empresas_respostas/responses", EmpresaRespostaController, :create_all
    get "/empresas/:id/questionario", QuestionarioController, :questionario_empresa
  end
end
