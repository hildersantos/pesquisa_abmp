defmodule PesquisaABMP.EmpresaRespostaController do
  use PesquisaABMP.Web, :controller

  alias PesquisaABMP.EmpresaResposta

  plug :authenticate
  plug :scrub_params, "empresa_resposta" when action in [:create, :update]

  def index(conn, _params) do
    empresas_respostas = Repo.all(EmpresaResposta)
    render(conn, :index, empresas_respostas: empresas_respostas)
  end

  def create(conn, %{"empresa_resposta" => empresa_resposta_params}) do
    changeset = EmpresaResposta.changeset(%EmpresaResposta{}, empresa_resposta_params)

    case Repo.insert(changeset) do
      {:ok, empresa_resposta} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", api_empresa_resposta_path(conn, :show, empresa_resposta))
        |> render(:show, empresa_resposta: empresa_resposta)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PesquisaABMP.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def create_all(conn, %{"empresas_respostas" => empresas_respostas_params}, user) do
    empresas_respostas = Repo.all(EmpresaResposta)

    new_params = empresas_respostas_params |> List.first()
    changeset = EmpresaResposta.changeset(%EmpresaResposta{}, new_params)
    case empresas_respostas_params |> Enum.each(&(Repo.insert_or_update!(EmpresaResposta.changeset(%EmpresaResposta{}, &1)))) do
      :ok ->
        user |> PesquisaABMP.Empresa.changeset(%{"status_pesquisa" => "concluida"}) |> Repo.update!
        # Disparo um email pra ABMP informando que a pesquisa foi concluída
        PesquisaABMP.Mailer.finished_survey_email(conn, user)

        conn
        |> put_status(:created)
        |> put_resp_header("location", api_empresa_resposta_path(conn, :index))
        |> render("index.json", empresas_respostas: empresas_respostas)
      _ ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PesquisaABMP.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "empresa_resposta" => empresa_resposta_params}) do
    empresa_resposta = Repo.get!(EmpresaResposta, id)
    changeset = EmpresaResposta.changeset(empresa_resposta, empresa_resposta_params)

    case Repo.update(changeset) do
      {:ok, empresa_resposta} ->
        render(conn, :show, empresa_resposta: empresa_resposta)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PesquisaABMP.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    empresa_resposta = Repo.get!(EmpresaResposta, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(empresa_resposta)

    send_resp(conn, :no_content, "")
  end

  def action(conn, _) do
    apply(__MODULE__, action_name(conn), [conn, conn.params, conn.assigns.current_user])
  end
end
