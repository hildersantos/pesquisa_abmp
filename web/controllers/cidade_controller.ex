defmodule PesquisaABMP.CidadeController do
  use PesquisaABMP.Web, :controller

  alias PesquisaABMP.Cidade

  plug :authenticate
  plug :only_admins
  plug :scrub_params, "cidade" when action in [:create, :update]

  def index(conn, _params) do
    cidades = Repo.all(Cidade)
    render(conn, "index.html", cidades: cidades)
  end

  def new(conn, _params) do
    changeset = Cidade.changeset(%Cidade{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"cidade" => cidade_params}) do
    changeset = Cidade.changeset(%Cidade{}, cidade_params)

    case Repo.insert(changeset) do
      {:ok, _cidade} ->
        conn
        |> put_flash(:info, "Cidade criada com sucesso.")
        |> redirect(to: cidade_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    cidade = Repo.get!(Cidade, id)
    render(conn, "show.html", cidade: cidade)
  end

  def edit(conn, %{"id" => id}) do
    cidade = Repo.get!(Cidade, id)
    changeset = Cidade.changeset(cidade)
    render(conn, "edit.html", cidade: cidade, changeset: changeset)
  end

  def update(conn, %{"id" => id, "cidade" => cidade_params}) do
    cidade = Repo.get!(Cidade, id)
    changeset = Cidade.changeset(cidade, cidade_params)

    case Repo.update(changeset) do
      {:ok, cidade} ->
        conn
        |> put_flash(:info, "Cidade atualizada com sucesso.")
        |> redirect(to: cidade_path(conn, :show, cidade))
      {:error, changeset} ->
        render(conn, "edit.html", cidade: cidade, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    cidade = Repo.get!(Cidade, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(cidade)

    conn
    |> put_flash(:info, "Cidade excluída com sucesso.")
    |> redirect(to: cidade_path(conn, :index))
  end
end
