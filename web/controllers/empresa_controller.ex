defmodule PesquisaABMP.EmpresaController do
  use PesquisaABMP.Web, :controller

  alias PesquisaABMP.Empresa
  alias PesquisaABMP.EmpresaResposta

  plug :authenticate
  plug :only_admins
  plug :scrub_params, "empresa" when action in [:create, :update]

  def index(conn, params) do
    empresas = Empresa |> Ecto.Query.preload(:segmento) |> Ecto.Query.preload(:cidade) |> Ecto.Query.order_by(asc: :nome) |> Repo.all
    render(conn, "index.html", empresas: empresas)
  end

  def new(conn, _params) do
    changeset = Empresa.changeset(%Empresa{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"empresa" => empresa_params}) do
    changeset = Empresa.registration_changeset(%Empresa{}, empresa_params)

    case Repo.insert(changeset) do
      {:ok, empresa} ->
        conn
        |> put_flash(:info, "#{empresa.nome} criada!")
        |> redirect(to: empresa_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    empresa = Repo.get!(Empresa, id) |> Repo.preload(:cidade) |> Repo.preload(:segmento) |> Repo.preload(dados_empresa: [:cidade, :segmento])
    empresa_query = from e in Empresa,
      where: e.id == ^id
    questionario = empresa_query |> Empresa.get_questionario |> Repo.one
    render(conn, "show.html", empresa: empresa, questionario: questionario)
  end

  def edit(conn, %{"id" => id}) do
    empresa = Repo.get!(Empresa, id)
    changeset = Empresa.changeset(empresa)
    render(conn, "edit.html", empresa: empresa, changeset: changeset)
  end

  def update(conn, %{"id" => id, "empresa" => empresa_params}) do
    empresa = Repo.get!(Empresa, id)
    changeset = Empresa.changeset(empresa, empresa_params)

    case Repo.update(changeset) do
      {:ok, empresa} ->
        conn
        |> put_flash(:info, "#{empresa.nome} atualizada!")
        |> redirect(to: empresa_path(conn, :show, empresa))
      {:error, changeset} ->
        render(conn, "edit.html", empresa: empresa, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    empresa = Repo.get!(Empresa, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(empresa)

    conn
    |> put_flash(:info, "#{empresa.nome} excluída com sucesso.")
    |> redirect(to: empresa_path(conn, :index))
  end
end
