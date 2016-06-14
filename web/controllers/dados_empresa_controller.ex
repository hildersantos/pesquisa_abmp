defmodule PesquisaABMP.DadosEmpresaController do
  use PesquisaABMP.Web, :controller

  alias PesquisaABMP.DadosEmpresa
  alias PesquisaABMP.Empresa

  plug :authenticate
  plug :only_admins when action in [:show, :index, :delete]
  plug :scrub_params, "dados_empresa" when action in [:create, :update]

  def index(conn, _params, _user) do
    dados_empresas = Repo.all(DadosEmpresa) |> Repo.preload(:cidade) |> Repo.preload(:empresa) |> Repo.preload(:segmento)
    render(conn, "index.html", dados_empresas: dados_empresas)
  end

  def new(conn, _params, user) do
    if(user.status_pesquisa === "iniciada") do
      conn
      |> redirect(to: pesquisa_path(conn, :index))
      |> halt()
    end

    if(user.status_pesquisa === "concluida") do
      conn
      |> put_flash(:info, "Sua pesquisa já foi respondida. Obrigado!")
      |> redirect(to: page_path(conn, :final))
      |> halt()
    end

    changeset = user |> build_assoc(:dados_empresa) |> DadosEmpresa.changeset
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"dados_empresa" => dados_empresa_params}, user) do
    changeset =
    user
    |> build_assoc(:dados_empresa)
    |> DadosEmpresa.changeset(dados_empresa_params)


    case Repo.insert(changeset) do
      {:ok, _dados_empresa} ->
        user |> Empresa.changeset(%{"status_pesquisa" => "iniciada"}) |> Repo.update!

        conn
        |> put_flash(:info, "Dados atualizados com sucesso!")
        |> redirect(to: pesquisa_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    dados_empresa = Repo.get!(DadosEmpresa, id)
    render(conn, "show.html", dados_empresa: dados_empresa)
  end

  def edit(conn, %{"id" => id}) do
    dados_empresa = Repo.get!(DadosEmpresa, id)
    changeset = DadosEmpresa.changeset(dados_empresa)
    render(conn, "edit.html", dados_empresa: dados_empresa, changeset: changeset)
  end

  def update(conn, %{"id" => id, "dados_empresa" => dados_empresa_params}) do
    dados_empresa = Repo.get!(DadosEmpresa, id)
    changeset = DadosEmpresa.changeset(dados_empresa, dados_empresa_params)

    case Repo.update(changeset) do
      {:ok, dados_empresa} ->
        conn
        |> put_flash(:info, "Dados empresa updated successfully.")
        |> redirect(to: dados_empresa_path(conn, :show, dados_empresa))
      {:error, changeset} ->
        render(conn, "edit.html", dados_empresa: dados_empresa, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    dados_empresa = Repo.get!(DadosEmpresa, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(dados_empresa)

    conn
    |> put_flash(:info, "Dados empresa deleted successfully.")
    |> redirect(to: dados_empresa_path(conn, :index))
  end

  def action(conn, _) do
    apply(__MODULE__, action_name(conn), [conn, conn.params, conn.assigns.current_user])
  end
end
