defmodule PesquisaABMP.SegmentoController do
  use PesquisaABMP.Web, :controller

  alias PesquisaABMP.Segmento

  plug :authenticate
  plug :only_admins
  plug :assoc_questionarios
  plug :scrub_params, "segmento" when action in [:create, :update]

  def index(conn, _params) do
    segmentos = Repo.all(Segmento) |> Repo.preload(:questionario)
    render(conn, "index.html", segmentos: segmentos)
  end

  def new(conn, _params) do
    changeset = Segmento.changeset(%Segmento{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"segmento" => segmento_params}) do
    changeset = Segmento.changeset(%Segmento{}, segmento_params)

    case Repo.insert(changeset) do
      {:ok, _segmento} ->
        conn
        |> put_flash(:info, "Segmento created successfully.")
        |> redirect(to: segmento_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    segmento = Repo.get!(Segmento, id) |> Repo.preload(empresas: from(e in PesquisaABMP.Empresa, order_by: e.nome))
    render(conn, "show.html", segmento: segmento)
  end

  def edit(conn, %{"id" => id}) do
    segmento = Repo.get!(Segmento, id)
    changeset = Segmento.changeset(segmento)
    render(conn, "edit.html", segmento: segmento, changeset: changeset)
  end

  def update(conn, %{"id" => id, "segmento" => segmento_params}) do
    segmento = Repo.get!(Segmento, id)
    changeset = Segmento.changeset(segmento, segmento_params)

    case Repo.update(changeset) do
      {:ok, segmento} ->
        conn
        |> put_flash(:info, "Segmento updated successfully.")
        |> redirect(to: segmento_path(conn, :show, segmento))
      {:error, changeset} ->
        render(conn, "edit.html", segmento: segmento, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    segmento = Repo.get!(Segmento, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(segmento)

    conn
    |> put_flash(:info, "Segmento deleted successfully.")
    |> redirect(to: segmento_path(conn, :index))
  end

  defp assoc_questionarios(conn, _params) do
    questionarios = Repo.all(PesquisaABMP.Questionario) |> Enum.map(&{&1.nome,&1.id})
    conn
    |> assign(:questionarios, questionarios)
  end
end
