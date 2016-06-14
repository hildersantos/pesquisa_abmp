defmodule PesquisaABMP.QuestionarioController do
  use PesquisaABMP.Web, :controller

  alias PesquisaABMP.Questionario

  plug :authenticate when action in [:index, :show]
  plug :scrub_params, "questionario" when action in [:create, :update]

  def index(conn, _params) do
    questionarios = Repo.all(Questionario) |> Repo.preload([:segmentos, perguntas: :respostas])
    render(conn, :index, questionarios: questionarios)
  end

  def new(conn, _params) do
    changeset = Questionario.changeset(%Questionario{perguntas: [%PesquisaABMP.Pergunta{respostas: %PesquisaABMP.Resposta{}}]})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"questionario" => questionario_params}) do
    changeset = Questionario.changeset(%Questionario{}, questionario_params)

    case Repo.insert(changeset) do
      {:ok, questionario} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", api_questionario_path(conn, :show, questionario))
        |> render(:show, questionario: questionario)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PesquisaABMP.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    questionario = Repo.get!(Questionario, id) |> Repo.preload([:segmentos, perguntas: :respostas])
    render(conn, :show, questionario: questionario)
  end

  def update(conn, %{"id" => id, "questionario" => questionario_params}) do
    questionario = Repo.get!(Questionario, id) |> Repo.preload([:segmentos, perguntas: :respostas])
    changeset = Questionario.changeset(questionario, questionario_params)

    case Repo.update(changeset) do
      {:ok, questionario} ->
        render(conn, :show, questionario: questionario)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PesquisaABMP.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    questionario = Repo.get!(Questionario, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(questionario)

    send_resp(conn, :no_content, "")
  end


  # Ações personalizadas
  def questionario_empresa(conn, %{"id" => id}) do
    empresa = Repo.get!(PesquisaABMP.Empresa, id) |> Repo.preload([segmento: [questionario: [perguntas: {from(p in PesquisaABMP.Pergunta, order_by: p.id), :respostas}]]])
    render(conn, :show, questionario: empresa.segmento.questionario)
  end
end
