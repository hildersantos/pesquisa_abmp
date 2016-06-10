defmodule PesquisaABMP.DadosEmpresaController do
  use PesquisaABMP.Web, :controller

  alias PesquisaABMP.DadosEmpresa

  plug :scrub_params, "dados_empresa" when action in [:create, :update]

  def index(conn, _params) do
    dados_empresas = Repo.all(DadosEmpresa)
    render(conn, "index.html", dados_empresas: dados_empresas)
  end

  def new(conn, _params) do
    changeset = DadosEmpresa.changeset(%DadosEmpresa{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"dados_empresa" => dados_empresa_params}) do
    changeset = DadosEmpresa.changeset(%DadosEmpresa{}, dados_empresa_params)

    case Repo.insert(changeset) do
      {:ok, _dados_empresa} ->
        conn
        |> put_flash(:info, "Dados empresa created successfully.")
        |> redirect(to: dados_empresa_path(conn, :index))
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
end
